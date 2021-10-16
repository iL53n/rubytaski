import axios from 'axios'

// TASK
export function getTasks () {
    return axios.get('/tasks')
}