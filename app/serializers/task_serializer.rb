class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title
  # ToDo: add star serializer for relationship
  # https://github.com/sriniarul/jsonapi-serializer-custom/blob/5eb43e2813ec1cc573a25d37adae50a47ddd9373/spec/fixtures/movie.rb
  has_many :stars, if: Proc.new { |record| record.stars.any? }

  attribute :stars_dates do |object|
    object.stars.map do |s|
      {
        id:        s.id,
        state:     s.state,
        due_date:  s.due_date&.to_date,
        done_date: s.done_date&.to_date
      }
    end
  end

  # attribute :stars do |object|
  #   object.stars.map { |s| s }
  # end
end
