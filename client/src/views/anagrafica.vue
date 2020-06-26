<template>
<v-app id="inspire">
  <v-navigation-drawer v-model="drawer" app clipped>
    <v-list dense>
      <v-list-item to="/" @click="">
        <v-list-item-content>
          <v-list-item-title>Login</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/anagrafica" @click="">
        <v-list-item-content>
          <v-list-item-title>Anagrafica lastre</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/posizioni" @click="">
        <v-list-item-content>
          <v-list-item-title>Posizioni</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/giacenza" @click="">
        <v-list-item-content>
          <v-list-item-title>Giacenza</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item to="/inda" @click="">
        <v-list-item-content>
          <v-list-item-title>In preparazione</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item to="/inac" @click="">
        <v-list-item-content>
          <v-list-item-title> Trasferiti da P a J </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/invprima6" @click="">
        <v-list-item-content>
          <v-list-item-title> Inventario prima scelta 6 mm </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/invprima12" @click="">
        <v-list-item-content>
          <v-list-item-title> Inventario prima scelta 12 mm </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/invprim20" @click="">
        <v-list-item-content>
          <v-list-item-title> Inventario prima scelta 20 mm </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list-item to="/invterza" @click="">
        <v-list-item-content>
          <v-list-item-title> Inventario NON prima scelta </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item to="/about" @click="">
        <v-list-item-content>
          <v-list-item-title>About</v-list-item-title>
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
            <v-flex xs12 sm12 md12>
              <v-card class="elevation-12">
                <v-card-text>
                  <v-btn @click="getRequest()" color="cyan darken-2">view</v-btn>
                  <!--  <br /> {{data}} <br /> {{length}} <br /> {{headers}} -->
                </v-card-text>
                <v-data-table :headers="headers" :items="data" class="elevation">
                  <template slot="items" slot-scope="props">
                         <td v-for="header in headers">{{ props.item[header.value] }}</td>
                  </template>
                </v-data-table>
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
    data: [],
    headers: [],
    length: ''
  }),
  created() {
    this.$vuetify.theme.dark = true
  },
  methods: {
    getRequest: async function() {
      var self = this;
      axios.get('https://endpoint1.morandi.services/api/APP_ANAGRAFICAs?access_token=' + localStorage['TOKEN'].replace('"', ''))
        .then(function(response) {
          var tempHeaders = new Object();
          //self.data = JSON.stringify(response.data);
          tempHeaders = Object.keys(response.data[0]);
          self.length = Object.keys(response.data[0]).length;
          var c = '[';
          for (var i = 0; i < self.length; i++) {
            if (i < self.length - 1) {
              c = c + "{ \"text\" :\"" + tempHeaders[i] + "\" , \"value\" : \"" + tempHeaders[i] + "\" } ,";
            } else {
              c = c + "{ \"text\" : \"" + tempHeaders[i] + "\" , \"value\" : \"" + tempHeaders[i] + "\" } ";
            }
          }
          c = c + "]";
          self.headers = JSON.parse(c);


// RETREVE THE ROWS

          //  console.log(JSON.stringify(self.headers) );
          //    console.log(Object.keys(response.data).length);
          var r = '[';
          for ( i = 0; i < Object.keys(response.data).length; i++) {
            if (i < Object.keys(response.data).length - 1) {
              r = r + JSON.stringify(response.data[i]) + ",";
              //  console.log(r);
            } else {
              r = r + JSON.stringify(response.data[i]);
              //  console.log(r);
            }
          }
          r = r + "]";
          //  console.log(r );
          self.data = JSON.parse(r);
          //      console.log(self.data[0]);
        })
        .catch(function(error) {
          //  if(error){  alert("login fallito");}
          //  console.log(error);
          alert(error);
        });
    },
  },
}
</script>
