import axios from 'axios'

// TASK
export function getTasks () {
    return axios.get('/tasks')
}

export function postStar (params) {
    return axios.post('/stars', params )
}

export function updateStar (star) {
    return axios.patch('/stars/' + star.id, star )
}