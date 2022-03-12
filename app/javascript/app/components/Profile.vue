<template lang="pug">
  .q-pa-xl.row.items-start.justify-around.q-gutter-xl
    q-card(class="col-4" align="left")
      q-card-section
        q-item
          q-item-section(avatar)
            q-avatar.shadow-5(size="100px")
              q-img( :src="user.avatar_url")
              //- TODO: version with mouseover icon
              //- q-img( :src="user.avatar_url" @mouseover="showUpload = true" @mouseleave="showUpload = false")
              //-   p 
              //-     q-file(
              //-       v-model="avatar"
              //-       accept=".jpg,.png,.gif"
              //-       borderless
              //-       display-value
              //-       style="width: 100px"
              //-       @input="bannerShow=true; showUpload = true")
              //-       q-avatar(size="100px")      
              //-         q-img( :src="user.avatar_url" @mouseover="showUpload = true" @mouseleave="showUpload = false")
              //-           div
              //-             q-icon(v-if="showUpload" padding="xl"  size="70px" name="photo_camera" class="text-indigo-1")
          q-item-section
            q-item-label(class="text-h5") {{ user.nick_name }}
            q-item-label(caption) Registered: {{ user.created_at }}
      q-separator
      q-card-section
        q-card-section.text-h5.text-primary(align="center") Profile settings
        q-card-section.q-gutter-y-md.column
          q-file( 
            v-model="avatar"
            accept=".jpg,.jpeg,.png,.gif"
            label="Upload avatar"
            borderless
            use-chips
            style="width: 200px"
            @input="bannerShow=true")
            template(v-slot:prepend)
              q-icon(name="photo_camera" @click.stop)
          q-input(
            square
            filled
            label="Nickname"
            v-model="user.nick_name"
            @input="bannerShow=true")
            template(v-slot:append)
              q-icon(name="person_pin")
          q-input(
            square
            filled
            label="Email"
            v-model="user.email"
            @input="bannerShow=true")
            template(v-slot:append)
              q-icon(name="email")
          //- TODO: add change password request
          q-input(
            square
            filled
            label="Date of birth"
            v-model="user.date_of_birth"
            mask="date"
            @input="bannerShow=true")
            template(v-slot:append)
              q-icon(name="calendar_today")
                q-popup-proxy(ref="qDateProxy" transition-show="scale" transition-hide="scale")
                  q-date(v-model="user.date_of_birth" @input="bannerShow=true")
                    div(class="row items-center justify-end")
                      q-btn(v-close-popup label="Close" color="primary" flat)
          q-select(
            square
            filled
            label="Language"
            v-model="user.locale"
            :options="localesOptions"
            option-value="id"
            option-label="desc"
            option-disable="inactive"
            emit-value
            map-options
            @input="bannerShow=true")
        p(v-if="user.parent") Parent: {{ user.parent }}
        q-card-section
          q-banner(v-if="bannerShow" disable inline-actions rounded class="bg-green-1")
            .text-subtitle1.text-green-6 Сохранить изменения?
            template(v-slot:action)
              q-btn(@click="updateUser()" flat round color="green-7" icon="check")
              q-btn(@click="getCurrentUser()" flat round color="red-7" icon="close")
</template>

<script>

  export default {
    data () {
      return {
        localesOptions: [{id: 'ru', desc: 'Русский' }, { id: 'en', desc: 'English'}],
        bannerShow: false,
        showUpload: false,
        avatar: null
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
    created() {
    },
    methods: {
      getCurrentUser() {
        this.$backend.users.current()
          .then((response) => {
            this.user = response.data.user
            this.avatar = null
          })
          .catch((error) => {
            this.error = true
            console.log('ERROR! Message: ' + error.message)
          })
          .finally(() => {
            this.loading = false
            this.bannerShow = false
          })
      },
      updateUser() {
        const params = {
          'id'           : this.user.id,
          'nick_name'    : this.user.nick_name,
          'email'        : this.user.email,
          'date_of_birth': this.user.date_of_birth,
          'locale'       : this.user.locale,
        }

        let formData = new FormData()
        Object.entries(params).forEach(
          ([key, value]) => formData.append(key, value)
        )

        let newAvatar = false
        if (this.avatar !== null) {
          newAvatar = true
          formData.append('avatar', this.avatar)
        }

        this.$backend.users.update(formData)
          .then((response) => {
            this.$q.notify({
              message: "Updated the user!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "The user didn't update!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => {
            this.loading = false
            this.bannerShow = false
            if (newAvatar) { window.location.reload() }
          })
      },
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

