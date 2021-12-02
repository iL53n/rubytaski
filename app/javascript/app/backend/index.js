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
    index:   ()       => adapter.get('tasks'),
    create:  (params) => adapter.post('tasks', params),
    destroy: (id)     => adapter.delete(`tasks/${id}`)
  },
  stars: {
    create:  (params) => adapter.post('stars', params),
    // update:  (star)   => adapter.patch(`stars/${star,id}`, star),
    destroy: (id)     => adapter.delete(`stars/${id}`)
  },
  statistics: {
    index:   ()       => adapter.get('statistics'),
  }
}

export {
  backend
}