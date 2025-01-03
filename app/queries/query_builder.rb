class QueryBuilder
  attr_reader :params, :initial_scope, :filter, :sort, :perfomed_scope, :resources, :pagination

  def initialize(params, initial_scope)
    @params = params
    @initial_scope = initial_scope
    @performed_scope = @initial_scope
    perform
  end

  private

  def perform
    perform_scope
    perform_filter
    perform_sort
    perform_pagination
  end

  def perform_scope
    @scopes = @params[:scopes]
    return unless @scopes.present?

    @scopes = @scopes.split(',')
    @scopes.each.with_index(1) do |scope, index|
      if @initial_scope.respond_to?(scope)
        @performed_scope = @initial_scope.klass.none if index == 1
        @performed_scope = @performed_scope.or(@initial_scope.public_send(scope))
      end
    end
  end

  def perform_filter
    @search = params[:search]
    return if @search.blank?

    if @performed_scope.klass.respond_to?(:search)
      @performed_scope = @performed_scope.merge(@performed_scope.klass.search(@search))
    end
  end

  def perform_sort
    @sort = params[:sort]
    if @sort.blank?
      %w[state order].each do |attr|
        @performed_scope = @performed_scope.reorder(attr.to_sym) if @performed_scope.klass.column_names.include?(attr)
      end
      return
    end

    sort_params = {}
    split_params = @sort.split(',')
    split_params.each do |sort|
      sort = sort.split('|')
      next unless @performed_scope.klass.column_names.include?(sort.first) && %w[asc desc].include?(sort.last)

      sort_params[sort.first] = sort.last
    end

    sort_params = {}
    sort_params[@sort] = @params[:desc] == 'true' ? :desc : :asc

    @performed_scope = @performed_scope.reorder(sort_params)
  end

  def perform_pagination
    total = @performed_scope.count

    page = (@params[:page] || 1).to_i
    # TODO: fix it: add pagination to tables
    per_page = (@params[:per_page] || 50).to_i
    @resources = @performed_scope.page(page).per(per_page)

    total_pages = @resources.total_pages
    from = @resources.offset_value + 1
    to = @resources.offset_value + @resources.count

    @pagination = OpenStruct.new(
      rowsNumber: total,
      page: page,
      rowsPerPage: per_page,
      total_pages: total_pages,
      from: from,
      to: to
    )
  end
end
