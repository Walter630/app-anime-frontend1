<template>
    <v-app-bar :elevation="2" height="250" image="/imgs/janela1.jpg" cover >
        <v-avatar size="100" image="/imgs/Nanatsu.jpg"></v-avatar>
                <!-- Ícone sobreposto -->
                <v-btn
                    icon
                    position-reactive
                >
                    <v-icon>mdi-pencil</v-icon>
                </v-btn>
    </v-app-bar>
    
    <v-container>
        <main class="pa-0" style="margin-top: 250px">
            <v-cols cols="2" ma-0 pa-0>
                <v-card >
                    <v-card-title >
                    <h3>Conta</h3>
                        <h2>{{ todoStore.userLogado?.name || 'Usuário não logado'}} </h2>
                        <small v-if="todoStore.userLogado && todoStore.userLogado.email" class="text-h5">
                       {{ todoStore.userLogado.email }}
                        </small>
                    </v-card-title>
                
                </v-card>
            </v-cols>
            <v-menu offset-overflow>
                <template v-slot:activator="{ props }">
                    <v-btn  dark v-bind="props">
                        <v-icon>mdi-account</v-icon>
                </v-btn>
                </template>
                <v-card>
                    
                </v-card>
                <v-cols v-for="(ep, index) in todoStore.userLogado?.episodiosAssistidos || []" :key="index">
                <v-card>    
                    <v-card-title>
                        {{ ep.name || 'Anime desconhecido' }}
                        Capítulo {{ ep.episodios }}: {{ ep.title }}
                    </v-card-title>
                </v-card>
            </v-cols>
            </v-menu>
            
              </main>
    </v-container>
</template>
  
<script >
import {useTodoStore} from '@/stores/todoStore'
import { computed } from "vue";
import TodoLogin from '@/components/TodoLogin.vue';
import AnimeDetailsView from '../views/AnimeDetailsView.vue';


export default {
    components: {TodoLogin, AnimeDetailsView},
    setup() {
        const todoStore = useTodoStore()
        const usuarios = todoStore.usuarios

        const useEdit = computed(() => {
            return todoStore.userLogado ? todoStore.userLogado : null;
        });

        const marcarComoAssistido = (ep) => {
            ep.assistido = true;
        };

        return{
            usuarios,
            useEdit,
            todoStore,
            marcarComoAssistido
        }
    }
}

  </script>
