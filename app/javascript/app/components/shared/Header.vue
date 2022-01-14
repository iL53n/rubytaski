<template lang="pug">
    q-header(class="bg-white" style="height: 50px")
      q-toolbar
        q-toolbar-title(class="text-primary") rubytaski
        q-chip(size="20px" square color="primary" text-color="white")
          q-avatar
            img(src="https://cdn.quasar.dev/img/boy-avatar.png")
          | {{ user.email }}
          q-menu(anchor="bottom end" self="top end")
            q-list(style="min-width: 250px")
              q-item(class="text-white" style="background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);")
                q-item-section
                  div(v-if="user.first_name && user.last_name" class="text-h5 ") {{ user.first_name }} {{ user.last_name }}
                  .text-subtitle3 {{ user.email }}
                  div(v-if="user.age" class="text-subtitle1 ") {{ $t('menu.top.profile.age', { msg: user.age }) }}
              q-item(to="/statistics" v-ripple)
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
.profile-icon {
  border-radius: 5px;
  padding: 10px
}
</style>