<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="resources/css/bootstrap-reboot.css">
        <link rel="stylesheet" href="resources/css/bootstrap.css">
        <link rel="stylesheet" href="resources/css/bootstorage.css">
        <link rel="stylesheet" href="resources/css/style.css">
        <script src="resources/js/jquery.js"></script>
        <script src="resources/js/popper.js"></script>
        <script src="resources/js/bootstrap.js"></script>
        <script src="resources/js/mask.js"></script>
        <script src="resources/js/bootstorage.js"></script>
        <script src="resources/js/main.js"></script>
        <title>Teste Windi</title>
    </head>
    <body>

        <section>
            <div class="titulo container text-center py-5 my-2">
                <h1 class="display-4">Teste Windi</h1>
            </div>
        </section>

        <section class="busca bg-secondary py-4 mb-5">
            <div class="container">
                <form class="row justify-content-center buscar_veiculos_form" action="">
                    <div class="col-12 col-md-4 col-lg-5 form-group align-self-end">
                        <label class="col-form-label mr-2 text-light">Modelo</label>
                        <select class="custom-select lista_modelos" name="modelo"></select>
                    </div>
                    <div class="col-12 col-md-4 col-lg-5 form-group">
                        <label class="col-form-label mr-2 text-light">Busca</label>
                        <input type="text" name="busca" class="form-control" placeholder="Buscar por placa ou renavam">
                    </div>
                    <div class="col-8 col-sm-4 col-lg-2 form-group align-self-lg-end">
                        <button type="button" class="btn btn-warning w-100 buscar_veiculos">Buscar</button>
                    </div>
                </form>
            </div>
        </section>

        <section class="tabela container min-h-35">
            <button type="button" class="add_veiculo btn btn-success mb-4">Adicionar Novo Veículo</button>

            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Modelo</th>
                        <th scope="col">Placa</th>
                        <th scope="col">Renavam</th>
                        <th scope="col">Valor R$</th>
                        <th scope="col" class="col-1">Ações</th>
                    </tr>
                </thead>
                <tbody class="veiculos"></tbody>
            </table>
        </section>

        <!-- MODAL EDITOR -->
        <form class="modal fade" id="editor" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" action="">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content position-relative">
                    <div class="modal-header bg-light text-5">
                        <h5 class="modal-title">Veículo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body row">
                        <input type="hidden" name="id_interno">

                        <div class="form-group col col-6">
                            <label>Modelo</label>
                            <select class="custom-select lista_modelos" name="modelo"></select>
                        </div>
                        <div class="form-group col col-6">
                            <label>Valor R$</label>
                            <input type="text" name="valor_venda" class="form-control mask money">
                        </div>

                        <div class="form-group col">
                            <label>Placa</label>
                            <input type="text" name="placa" class="form-control mask personal" data-attr-mask="SSS-0000" placeholder="***-****">
                        </div>
                        <div class="form-group col">
                            <label>Renavam</label>
                            <input type="text" name="renavam" class="form-control mask numeric zeros" placeholder="***********">
                        </div>
                        <div class="form-group col data_cadastro">
                            <label>Data de Cadastro</label>
                            <input type="text" name="data_cadastro" class="form-control" disabled="disabled">
                        </div>

                        <div class="col-12">
                            <span class="title_item">Informações Adicionais</span>                             
                        </div>
                        <div class="col-12 row lista_opcionais"></div>

                        <div class="col-12 mt-4">
                            <div class="alert alert-danger alert_editor" role="alert"></div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success px-3 submeter_veiculo mx-3">Ok</button>
                        <button type="button" class="btn btn-secondary px-3" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </form>

        <!-- MODAL VISUALIZADOR -->
        <div class="modal fade" id="visualizador" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content position-relative">
                    <div class="modal-header bg-light text-5">
                        <h5 class="modal-title">Veículo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body row">
                        <div class="col-6">
                            <span class="titulo_visualizador">Modelo</span>
                            <span class="content_visualizador cv_modelo"></span>
                        </div>
                        <div class="col-6">
                            <span class="titulo_visualizador">Valor R$</span>
                            <span class="content_visualizador cv_valor"></span>
                        </div>
                        <div class="col-4 mt-4">
                            <span class="titulo_visualizador">Placa</span>
                            <span class="content_visualizador cv_placa"></span>
                        </div>
                        <div class="col-4 mt-4">
                            <span class="titulo_visualizador">Renavam</span>
                            <span class="content_visualizador cv_renavam"></span>
                        </div>
                        <div class="col-4 mt-4">
                            <span class="titulo_visualizador">Data de Cadastro</span>
                            <span class="content_visualizador cv_data"></span>
                        </div>
                        <div class="col-12 mt-4">
                            <span class="title_item">Informações Adicionais</span>                             
                        </div>
                        <div class="col-12 row lista_opcionais"></div>
                    </div>
                    <div class="modal-footer position-relative d-block w-100">
                        <button type="button" class="float-right btn btn-secondary px-3" data-dismiss="modal">Fechar</button>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="load">
            <span class="d-block text-center h2 text-white">Carregando...</span>
        </div>

        <div class="py-3"></div>

        <footer class="border-top bg-light mt-5 py-4 text-right text-muted">
            <div class="container">
                <span>Paulo Sérgio Pereira</span>
            </div>
        </footer>
    </body>
</html>