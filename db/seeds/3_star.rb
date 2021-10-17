# unless Star.any?
#   Task.all.each do |task|
#     @date = Time.zone.now
#
#     [0, 1, 2].each do |state|
#       Star.create!(
#         state: state,
#         user:     User.first,
#         task:     task,
#         due_date: @date
#       )
#
#       @date += 86400
#     end
#   end
# end

unless Star.any?
  @date = Time.zone.now

  Task.all.each do |task|
    @date = Time.zone.now

      Star.create!(
        user:     User.first,
        task:     task,
        due_date: @date
      )
  end

  @date += 86400
end