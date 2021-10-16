titles = [ 'Застелить кровать',
           'Сделать зарядку',
           'Помочь маме',
           'Убрать рабочий стол',
           'Позаниматься англ.яз',
           'Сделать ДЗ',
           'Почиатать перед сном' ]

unless Task.any?
  titles.each do |title|
    Task.create!(
      title: title,
      description: "description description description description description description description description ",
      user: User.first
    )
  end
end