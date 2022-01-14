<template lang="pug">
  q-layout(v-if="user" view="lHr lpR fFf")
    header-component
    left-menu
    right-menu

    q-page-container(align="middle")
      router-view
</template>

<script>
  import Languages       from 'config/quasar/lang/index.json'
  import HeaderComponent from 'components/shared/Header'
  import LeftMenu        from 'components/shared/LeftMenu'
  import RightMenu       from 'components/shared/RightMenu'
  
  export default {
    data () {
      return {
      }
    },
    computed: {
      user: {
        get() {
          return this.$store.state.currentUser
        },
        set(value) {
          this.$store.commit('updateCurrentUser', value)
        }
      }
    },
    created () {
      this.setCurrentUser()
      this.$backend.locale()
        .then((response) => {
          this.setLocale(response.data.locale)
        })
    },
    methods: {
      setCurrentUser() {
        this.$backend.users.current()
          .then((response) => {
            this.user = response.data.user
            // this.setLocale(response.data.user.locale)
        })
      },
      setLocale(locale) {
        this.$i18n.locale = locale

        let qLang = Languages.find(qLang => qLang.isoName === locale)
        import(`config/quasar/lang/${qLang !== undefined ? qLang.isoName : 'en-us'}`)
          .then(locale => this.$q.lang.set(locale.default))
      }
    },
    components: {
      HeaderComponent,
      LeftMenu,
      RightMenu
    }
  }
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
div {
  background: rgb(248, 247, 253)
}
</style>