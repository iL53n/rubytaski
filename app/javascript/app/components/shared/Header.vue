<template lang="pug">
    q-header(class="bg-white" style="height: 50px")
      q-toolbar
        q-toolbar-title(class="text-primary") rubytaski
        q-chip(size="20px" square color="primary" text-color="white")
          q-avatar
            img(src="https://cdn.quasar.dev/img/boy-avatar.png")
          | Bogdan
          q-menu(anchor="bottom end" self="top end")
            q-list(style="min-width: 250px")
              q-item(class="text-white" style="background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);")
                q-item-section 
                  .text-h5 Bogdan Gribko
                  .text-subtitle1 9 years
              q-item(to="/" v-ripple)
                q-item-section(avatar)
                  q-icon(class="text-primary bg-deep-purple-1 profile-icon" name="insert_chart_outlined")
                q-item-section(class="text-blue-grey-8")
                  .text-subtitle1 Statistics
                  .text-caption Full information about your activity
              q-separator(spaced inset)
              q-item(to="/" v-ripple)
                q-item-section(avatar)
                  q-icon(class="text-primary bg-deep-purple-1 profile-icon" name="settings")
                q-item-section(class="text-blue-grey-8")
                  .text-subtitle1 Settings
                  .text-caption Your private setings and configuration
              q-separator(spaced inset)
              q-item(align="between")
                q-item-section
                  div(class="row justify-center")
                    q-btn(color="primary" no-caps v-close-popup icon-right="logout" label="Sign Out")
</template>

<script></script>

<style scoped>
.profile-icon {
  border-radius: 5px;
  padding: 10px
}
</style>