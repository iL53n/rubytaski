<template lang="pug">
    q-header(class="bg-white" style="height: 50px")
      q-toolbar
        //- q-item(v-if="$q.platform.is.mobile" class="bg-primary")
        q-avatar.bg-primary(v-if="$q.platform.is.mobile" square)
          q-btn(href="/" padding="none" square flat id="square")
        q-toolbar-title
          q-btn(flat to="/" class="text-primary" size="lg" padding="xs" label="rubytaski" no-caps)
          // q-badge(align="top" color="orange") v1.0.0b
          // q-btn(flat @click="miniState = !miniState" round dense color="primary" icon="menu")
        q-chip(size="20px" square color="primary" text-color="white")
          //q-item-section(avatar) add some gap between avatar and nik
          q-avatar(rounded)
            q-img(v-if="user.avatar_url" :src="user.avatar_url")
            q-img(v-else :src="require('images/star.png')")
          q-item-section.text-subtitle2.text-weight-bold {{ user.nick_name }}
          q-menu(anchor="bottom end" self="top end")
            q-list(style="min-width: 250px")
              q-item(class="text-white" style="background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);")
                q-item-section
                  .text-subtitle3 {{ user.email }}
                  div(v-if="user.date_of_birth" class="text-subtitle1 ") {{ $t('menu.top.profile.age', { msg: age }) }}
              q-item(to="/my_statistics" v-ripple)
                q-item-section(avatar)
                  q-icon(class="text-primary bg-deep-purple-1 profile-icon" name="insert_chart_outlined")
                q-item-section(class="text-blue-grey-8")
                  .text-subtitle1 {{ $t('menu.top.profile.my_stat') }}
                  .text-caption {{ $t('menu.top.profile.my_stat_description') }}
              q-separator(spaced inset)
              q-item(to="/profile" v-ripple)
                q-item-section(avatar)
                  q-icon(class="text-primary bg-deep-purple-1 profile-icon" name="settings")
                q-item-section(class="text-blue-grey-8")
                  .text-subtitle1 {{ $t('menu.top.profile.my_config') }}
                  .text-caption {{ $t('menu.top.profile.my_config_description') }}
              q-separator(spaced inset)
              q-item(align="between")
                q-item-section
                  div(class="row justify-center")
                    q-btn(
                      type="a"
                      data-method="delete"
                      href="/users/sign_out"
                      color="primary"
                      no-caps
                      v-close-popup
                      icon-right="logout"
                      @click="setNullCurrentUser()"
                      :label="`${ $t('menu.top.profile.sign_out') }`"
                    )
</template>

<script>
  export default {
    data () {
      return {
        no_photo: require('../../assets/images/star.png')
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
      },
      age() {
        var today = new Date();
        var birth_date = new Date(this.user.date_of_birth)
        return Math.floor((today - birth_date) / (365*24*60*60*1000))
      }
    },
    created () {
    },
    methods: {
      setNullCurrentUser() {
        this.user = null
      }
    },
    components: {
    }
  }
</script>

<style scoped>
  #square {
    width: 25px;
    height: 25px;
    border-color: #fff200;
    border-style: solid;
    border-width: 4px
  }
.profile-icon {
  border-radius: 5px;
  padding: 10px
}
</style>
