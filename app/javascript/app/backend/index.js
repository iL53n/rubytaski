import axios from 'axios'

let token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const adapter = axios.create({
  baseURL: '/',
  headers: {
    'Accept': 'application/json'
  }  
})

const backend = {
  tasks: {
    index:   (params) => adapter.get('tasks', { params: params }),
    create:  (params) => adapter.post('tasks', params),
    show:    (id)     => adapter.get(`tasks/${id}`),
    update:  (task)   => adapter.patch(`tasks/${task.id}`, task),
    destroy: (id)     => adapter.delete(`tasks/${id}`)
  },
  goals: {
    index:   (params) => adapter.get('goals', { params: params }),
    create:  (params) => adapter.post('goals', params),
    show:    (id)     => adapter.get(`goals/${id}`),
    update:  (goal)   => adapter.patch(`goals/${goal.id}`, goal),
    destroy: (id)     => adapter.delete(`goals/${id}`)
  },
  stars: {
    create:  (params) => adapter.post('stars', params),
    // update:  (star)   => adapter.patch(`stars/${star,id}`, star),
    destroy: (id)     => adapter.delete(`stars/${id}`)
  },
  statistics: {
    heatmap: ()       => adapter.get('heatmap_stat'),
    stars:   ()       => adapter.get('stars_stat'),
    current: ()       => adapter.get('current_stat')
  },
  locale: () => adapter.get('locale')
}

export {
  backend
}