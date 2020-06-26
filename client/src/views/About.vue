<template>
<v-app id="inspire">
  <v-navigation-drawer v-model="drawer" app clipped>
    <v-list dense>
      <v-list-item to="/" @click="">
        <v-list-item-content>
          <v-list-item-title>Menù</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

    </v-list>
  </v-navigation-drawer>
  <v-app-bar app clipped-left>
    <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    <v-toolbar-title>Logistics cockpit</v-toolbar-title>
  </v-app-bar>
  <v-content>
    <v-container class="fill-height" fluid>
      <v-row align="center" justify="center">
        <v-col>
          <v-layout align-center justify-center>
            <v-flex xs12 sm8 md4>
              <v-card class="elevation-12">
                <v-card-text>
                  About
                </v-card-text>
              </v-card>
            </v-flex>
          </v-layout>
        </v-col>
      </v-row>
    </v-container>
  </v-content>
  <v-footer app>
    <span>&copy; 2019</span>
  </v-footer>
</v-app>
</template>
<script>
export default {
  props: {
    source: String,
  },
  data: () => ({
    drawer: null,
    email: '',
    password: '',
    token: ''
  }),
  created() {
    this.$vuetify.theme.dark = true
  },
  methods: {
  },
}
</script>
