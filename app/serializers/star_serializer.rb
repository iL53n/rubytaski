class StarSerializer
  include FastJsonapi::ObjectSerializer

  attributes :state, :due_date
end