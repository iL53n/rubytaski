// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"

import Vue from 'vue'
import App from '../app'

import { Quasar } from 'quasar'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
import '../app/assets/styles/quasar.sass'
import 'quasar/dist/quasar.ie.polyfills'
import quasar_params from './quasar_params'
import '@quasar/quasar-ui-qcalendar/dist/index.css'
import QCalendar from '@quasar/quasar-ui-qcalendar'

Vue.use(Quasar, quasar_params)
Vue.use(QCalendar)

Rails.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({ render: h => h(App) }).$mount();
    document.body.appendChild(app.$el)
});

// document.addEventListener('DOMContentLoaded', () => {
//     new Vue({
//         el: '#app',
//         render: h => h(App)
//     })
// })