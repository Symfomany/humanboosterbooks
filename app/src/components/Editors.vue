<template>
    <div>
        <h3>Hello Guys</h3>
        <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Magni molestias at, tenetur illum doloribus quasi
            eligendi voluptatem quaerat iusto rem corrupti. Nesciunt nisi, quasi delectus molestiae nemo nam unde eum!</p>


        <hr>

        <p v-for="editorNameNbBook in editors" :key="editorNameNbBook.id"> Nom de l'éditeur
            <i class="fas fa-list-item"></i>
            {{ editorNameNbBook.name }} : nombre livre {{ editorNameNbBook.nb_books }}
        </p>

        <hr>

        <p :key="nb_editor.id"> Nb éditeur
            <i class="fas fa-list-item"></i>
            {{ nb_editor.nb_editor }}
        </p>



        <h3>Les éditeurs</h3>

        <table class="table">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th colspan="2">Editeurs</th>
                    <th scope="col"><button type="button" class="btn  btn-custom" data-bs-toggle="modal"
                            data-bs-target="#exampleModal">
                            +</button></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="editor in editors_all_data" :key="editor.id">
                    <th scope="row"> {{ editor.id }}</th>
                    <td>{{ editor.name }}</td>
                    <td></td>
                    <td>
                        <a href="#">
                            <img class="icons_crud_editors" src="https://cdn-icons-png.flaticon.com/128/2312/2312022.png"
                                alt="">
                        </a>

                        <a @click="supprimerEditeur" href="#">
                            <img class="icons_crud_editors" src="https://cdn-icons-png.flaticon.com/128/8134/8134370.png"
                                alt="">
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>



        <!-- Button trigger modal -->


        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ajouter un éditeur</h5>
                    </div>
                    <div class="modal-body">

                        <input placeholder="Nom" type="text" class="form-control" v-model="name">
                        <input placeholder="Logo" type="text" class="form-control" v-model="logo">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                        <button @click="ajouterEditeur" type="button" class="btn btn-primary">Confirmer</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
 
 
 
 
<script>
import axios from 'axios';

export default {
    name: 'Editors',
    props: {},
    components: {
    },
    data() {
        return {
            authors: [],
            editors: [],
            editors_all_data: [],
            nb_editor: '',
            nb_author: '',
        }
    },
    methods: {
        async ajouterEditeur() {
            const { data } = await axios.post(`http://localhost:3000/editors`, {
                name: this.name,
                logo: this.logo,
            });

            this.editors_all_data.push({
                name: this.name,
                logo: this.logo,
            })

            this.name = ""
            this.logo = ""
        },

        async supprimerEditeur() {
            const { data } = await axios.delete(`http://localhost:3000/editors`, {
                name: this.name,
                logo: this.logo,
            });
        },


    },
    async created() {


        const editorsData = await axios.get(`http://localhost:3000/editors`);
        this.editors_all_data = editorsData.data

        const editorNameNbBook = await axios.get(`http://localhost:3000/editors_name_nb_books`);
        this.editors = editorNameNbBook.data

        const data_nb_editor = await axios.get(`http://localhost:3000/nb_editor`);
        this.nb_editor = data_nb_editor.data[0]
    }


}
</script>
 
 
<style>
.btn-custom {
    background-color: #3f3f3f;
    border: none;
    color: #acacac;
}

.btn-custom:hover {
    background-color: #acacac;
    color: #3f3f3f;
}

.icons_crud_editors {
    height: 2.2rem;
    padding: 0 10px;
}</style>