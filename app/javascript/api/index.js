import axios from 'axios'

// TASK
export function getTasks () {
    return axios.get('/tasks');
}

export function  postTask(params) {
    return axios.post('/tasks', params);
}

export function deleteTask (id) {
    return axios.delete('/tasks/' + id );
}

export function postStar (params) {
    return axios.post('/stars', params );
}

export function updateStar (star) {
    return axios.patch('/stars/' + star.id, star );
}

export function deleteStar (id) {
    return axios.delete('/stars/' + id );
}