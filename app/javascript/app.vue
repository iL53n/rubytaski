<template lang="pug">
q-layout(v-if="!!user" view="lHh lpr lFf" )
  header-component
  left-menu
  right-menu

  q-page-container(align="middle")
    //- q-btn(push label="TEST NOTIFICATION" @click="remind({task: {title: 'test'}})")
    //- audio(id="notificationSound")
    //-   source(src="/Users/Illia_Hrybko/Desktop/rt/rubytaski/app/javascript/app/assets/sounds/remind.mp3"  type="audio/mpeg")
    router-view
  div(v-if="$q.platform.is.mobile")
    footer-component


</template>

<script>
  import Languages       from 'config/quasar/lang/index.json'
  import HeaderComponent from 'components/shared/Header'
  import FooterComponent from 'components/shared/Footer'
  import LeftMenu        from 'components/shared/LeftMenu'
  import RightMenu       from 'components/shared/RightMenu'

  export default {
    data () {
      return {
        tab: 'images'
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
      this.user.locale ? this.setLocale(this.user.locale) : this.getLocale()
    },
    methods: {
      remind(data) {
        const title = data.task.title
        const icon = 'alarm'
        const notificationSound = document.getElementById("notificationSound");
        notificationSound.play()

        if ("Notification" in window) {
          Notification.requestPermission().then(function (permission) {
            if (permission === "granted") {
              var notification = new Notification(title, {
                body: new Date(),
                icon: require("images/rt_logo.png"),
                sound: "app/javascript/app/assets/sounds/remind.mp3",
                requireInteraction: true,
                data: {
                  sourceUrl: window.location.href,
                }
              });
              const sourceUrl = notification.data.sourceUrl

              notification.onclick = function () {
                notification.close();
                return window.focus(sourceUrl);
              };
            }
          });
        }

        this.$q.notify({
          icon: icon,
          message: title,
          color: 'warning',
          position: 'top',
          timeout: 6000,
          actions: [
            { icon: 'close', color: 'white', round: true, handler: () => { /* ... */ } }
          ]
        })
      },
      setCurrentUser() {
        this.$backend.users.current()
          .then((response) => {
            this.user = response.data.user
          })
          .catch((error) => {
            this.error = true
            console.log('ERROR! Message: ' + error.message)
          })
          .finally(() => {
            this.loading = false
          })
      },
      getLocale() {
        this.$backend.locale()
          .then((response) => {
            this.setLocale(response.data.locale)
          })
          .catch((error) => {
            this.error = true
            console.log('ERROR! Message: ' + error.message)
          })
          .finally(() => {
            this.loading = false
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
      FooterComponent,
      LeftMenu,
      RightMenu
    },
    subscriptions: {
      RemindersChannel: { received(data) { this.remind(data) } }
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
