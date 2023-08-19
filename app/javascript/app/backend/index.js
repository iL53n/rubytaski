import axios from 'axios'

let token = document.head.querySelector('meta[name="csrf-token"]').content
// let token = document.getElementsByName("csrf-token")[0].content

axios.defaults.headers.common['X-CSRF-TOKEN'] = token

const adapter = axios.create({
  baseURL: '/',
  headers: {
    'Accept': 'application/json'
  }
})

const backend = {
  tasks: {
    index:        (params) => adapter.get('tasks', { params: params }),
    create:       (params) => adapter.post('tasks', params),
    show:         (id)     => adapter.get(`tasks/${id}`),
    update:       (task)   => adapter.patch(`tasks/${task.id}`, task),
    update_order: (order)  => adapter.patch(`tasks/update_order`, { order: order }),
    set_state:    (params) => adapter.patch(`tasks/${params.id}/set_state`, params),
    destroy:      (id)     => adapter.delete(`tasks/${id}`),
    create_reminders: (params) => adapter.post(`tasks/${params.task_id}/reminders`, params)
  },
  goals: {
    index:   (params)   => adapter.get('goals', { params: params }),
    create:  (params)   => adapter.post('goals', params),
    show:    (id)       => adapter.get(`goals/${id}`),
    update:  (goal)     => adapter.patch(`goals/${goal.id}`, goal),
    set_state: (params) => adapter.patch(`goals/${params.id}/set_state`, params),
    destroy: (id)       => adapter.delete(`goals/${id}`)
  },
  stars: {
    create:  (params) => adapter.post('stars', params),
    // update:  (star)   => adapter.patch(`stars/${star,id}`, star),
    destroy: (id)     => adapter.delete(`stars/${id}`)
  },
  statistics: {
    index: (params) => adapter.get('statistics', { params: params })
  },
  users: {
    current: ()       => adapter.get('users/me'),
    update:  (user)   => adapter.patch(`users/${user.get('id')}`, user)
  },
  locale: () => adapter.get('locale')
}

export {
  backend
}
