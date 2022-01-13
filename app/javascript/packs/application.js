// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"

import Vue from 'vue'
import App from '../app'

import { Quasar }    from 'quasar'
import quasar_params from '../app/config/quasar/quasar_params'
import                    '@quasar/quasar-ui-qcalendar/dist/index.css'
import QCalendar     from '@quasar/quasar-ui-qcalendar'
import Heatmap       from 'vue-calendar-heatmap'
import VueApexCharts from 'vue-apexcharts'

import { backend }   from "../app/backend"
import router        from '../app/router'
import store         from '../app/store'
import i18n          from '../app/config/i18n'

import '../app/mixins'
import '../app/sockets'

Vue.use(Quasar, quasar_params)
Vue.use(QCalendar)
Vue.use(Heatmap)
Vue.component('apexchart', VueApexCharts)

Vue.prototype.$backend = backend

Rails.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({ 
    render: h => h(App),
    router,
    store,
    i18n
  }).$mount();
  document.body.appendChild(app.$el)
});