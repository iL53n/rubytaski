class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title
  has_many :stars
end