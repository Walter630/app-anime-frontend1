<template>
     <v-app-bar color="black" :elevation="2" dark >
    <template v-slot:prepend>
      <v-app-bar-nav-icon></v-app-bar-nav-icon>
    </template>

    <v-toolbar-title>Meus Animes</v-toolbar-title>
    <v-menu max-width="200px"  :close-on-content-click="false">
      <template v-slot:activator="{ props }">
      <v-btn icon color="primary" dark slot="activator" v-bind="props">
        <v-badge dot color="info"><!--slot can be any component-->
          <v-icon large color="primary">mdi-bell-outline</v-icon>
        </v-badge>
        <v-avatar image="/imgs/Nanatsu.jpg">
        </v-avatar>
      </v-btn>
    </template>
      <v-card>
      <v-card-text>
        <div class="mx-auto text-center">
            <v-avatar
              image="/imgs/Nanatsu.jpg"
            />
            <h3>{{ todoStore.userLogado?.name || 'Usuário não logado'}}</h3>
            <p>{{todoStore.userLogado?.email || 'Usuário não logado'}}</p>
            <v-divider class="my-3"></v-divider>
              <v-btn variant="text" rounded @click="editarConta()"> Editar conta </v-btn>
              <v-divider class="my-3"></v-divider>
              <v-btn variant="text" rounded @click="logout"> Sair </v-btn>
          </div>
      </v-card-text>   
      </v-card>
    </v-menu>

    <v-btn icon >
      <v-icon>mdi-magnify</v-icon>
    </v-btn>
    <v-menu max-width="20px" :close-on-content-click="false">
    <template v-slot:activator="{ props }">
        <v-btn  slot="activator" v-bind="props">
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>
      </template>
      
      <v-card>
        
        <v-card-text>
          <div class="mx-auto text-center"></div>
          <v-btn variant="text" rounded> Titulo </v-btn>
            <v-divider class="my-3"></v-divider>
            <v-btn variant="text" rounded> Sair </v-btn>
        </v-card-text>
      </v-card>
    </v-menu>
  </v-app-bar>

  <v-main class="background">
    <EditarAnime/>
  </v-main>

  <v-footer color="black" padless>
  <v-row class="text-center w-100">
    <v-col cols="12">
      <span class="white--text">© 2025 Meu App de Animes</span>
    </v-col>
  </v-row>
</v-footer>

    
</template>

<script>
import AdcionarAnime from './AdcionarAnime.vue';
import EditarAnime from './EditarAnime.vue';

import { useTodoStore } from '../stores/todoStore';
import { useRouter } from 'vue-router';
import TodoLogin from '../components/TodoLogin.vue';
export default {
    components: {AdcionarAnime, EditarAnime, TodoLogin},
    setup() {
      const todoStore = useTodoStore()
      const router = useRouter()
      const logout = () => {
            // Aqui você poderia limpar o token/login do usuário
          console.log('Usuário deslogado')
          router.push('/login')
        }
        const editarConta = () => {
            router.push({name: 'editarUsuario', params: { id: todoStore.userLogado.id } })
          }
    return{
      editarConta, 
      logout,
      todoStore
    }
    }
}

</script>

<style>
.background {
  min-height: 100vh;
  background-color: #000000;
  
}
</style>