// import Vue from 'vue'

let loadingMixin = {
  data () {
    return {
      loading: true,
      error: false
    }
  }
}

export default loadingMixin

// Vue.mixin(loadingMixin) //=> global mixin