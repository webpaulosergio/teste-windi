/*Variáveis*/
let opcionais = {};
let modelos = {};
let loads = 0;
let modelo = `
<tr class="veiculo" data-id="{id_interno}">
    <th scope="row">{id_interno}</th>
    <td class="align-middle">{modelo_name}</td>
    <td class="align-middle">{placa}</td>
    <td class="align-middle">{renavam}</td>
    <td class="align-middle">{valor}</td>
    <td class="align-middle">
        <div class="btn-group dropleft actions_button">
            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
            <div class="dropdown-menu">
                <a class="dropdown-item visualizar_veiculo" href="#">Visualizar Veículo</a>
                <a class="dropdown-item editar_veiculo" href="#">Editar Veículo</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item excluir_veiculo" href="#">Excluir Veículo</a>
            </div>
        </div>
    </td>
</tr>
`;

/*Iniciando a aplicação*/
function startApp() {

    /*Verifica se tudo já foi carregado*/
    if (loads < 2) {
        return false;
    }

    /*Prepara a lista de modelos*/
    let modelList = modelos.map(function (i) {
        return `<option value="${i.id_interno}">${i.titulo}</option>`;
    });

    /*Insere a lista de modelos*/
    $(".lista_modelos").html(modelList);
    $(".busca .lista_modelos").prepend('<option value="" selected="selected">Todos</option>');

    /*Prepara a lista ítens opcionais*/
    let optionsList = opcionais.map(function (i) {
        return `
        <div class="form-group col-6 col-lg-4 my-0">
            <label class="custom-control custom-checkbox border-bottom border-color-e cursor-pointer py-3">
                <input type="checkbox" value="${i['id_interno']}" data-option_id="${i['id_interno']}" class="custom-control-input ck_opcionais" id="opcional_${i['id_interno']}">
                <span class="custom-control-label" for="opcional_${i['id_interno']}">${i['titulo']}</span>
            </label>
        </div>
        `;
    });

    /*Insere a lista de opcionais*/
    $(".lista_opcionais").html(optionsList);
    $("#visualizador .lista_opcionais .custom-checkbox").each(function (i, e) {
        $(this).removeClass('cursor-pointer');
        $(this).find('input').attr('disabled', 'disabled');
    });

    /*Remove a tela de carregamento*/
    $(".load").fadeOut("slow");
}

/*Buscar veículos*/
function searchVeiculos() {
    submitPost({
        'url': "search.jsp",
        'data': $(".buscar_veiculos_form").serialize(),
        'callSuccess': function (e) {
            $(".veiculos").html("");

            for (let i = 0; i < e.length; i++) {
                let veiculo = modelo;
                e[i]['valor'] = toMonetary(e[i]['valor_venda'], true);

                $.each(e[i], function (vk, vv) {
                    veiculo = veiculo.split(`{${vk}}`).join(vv);
                });

                $(".veiculos").append(veiculo);
            }
        },
        'callError': function (x, t, e) {
            alert("Houve um erro ao buscar os veículos no arquivo 'search.jsp'");
        }
    });
}

/*Buscar veículo*/
function searchVeiculo(veiculo, callback) {
    submitPost({
        'url': "search.jsp",
        'data': 'veiculo_id=' + veiculo,
        'callSuccess': function (e) {
            callback(e);
        },
        'callError': function (x, t, e) {
            alert("Houve um erro ao buscar os veículos no arquivo 'search.jsp'");
        }
    });
}

/*Função de abrir editor*/
function openEditor(veiculo) {
    let modal = $("#editor");

    modal.find('.modal-title').text((veiculo) ? 'Veículo #' + veiculo : 'Novo Veículo');
    modal.find('.submeter_veiculo').text((veiculo) ? 'Atualizar Veículo' : 'Adicionar Veículo');
    modal.find(".lista_modelos option:first").prop('selected', 'selected');

    modal.find(".excluir_veiculo").hide(0);
    modal.find(".data_cadastro").hide(0);
    modal.find(".alert").hide(0);


    if (veiculo != null) {
        modal.find(".excluir_veiculo").show(0);
        modal.find(".data_cadastro").show(0);
    }

    searchVeiculo(veiculo, function (e) {
        if (e.length > 0) {
            modal.find(".lista_modelos option[value='" + e[0]['modelo_id'] + "']").prop('selected', 'selected');
        }
        modal.find("input[name='id_interno']").val((e.length < 1) ? '' : e[0]['id_interno']);
        modal.find("input[name='valor_venda']").val((e.length < 1) ? '' : toMonetary(e[0]['valor_venda'], true));
        modal.find("input[name='placa']").val((e.length < 1) ? '' : e[0]['placa']);
        modal.find("input[name='renavam']").val((e.length < 1) ? '' : e[0]['renavam']);
        modal.find("input[name='data_cadastro']").val((e.length < 1) ? '' : formatData(e[0]['data_cadastro']).replace(" ", " às "));

        $("#editor .lista_opcionais .custom-checkbox").each(function (i) {
            let opcaoChecada = (e.length > 0 && $.inArray($(this).find('input').data('option_id'), e[0]['veiculo_opcionais']) >= 0);
            $(this).find('input').prop('checked', opcaoChecada);
        });

        modal.modal('show');
    });
}

/*Função de abrir visualizador*/
function openVisualizador(veiculo) {
    let modal = $("#visualizador");
    modal.find('.modal-title').text('Veículo #' + veiculo);

    searchVeiculo(veiculo, function (e) {
        modal.find(".cv_modelo").text(e[0]['modelo_name']);
        modal.find(".cv_valor").text("R$: " + toMonetary(e[0]['valor_venda'], true));
        modal.find(".cv_placa").text(e[0]['placa']);
        modal.find(".cv_renavam").text(e[0]['renavam']);
        modal.find(".cv_data").text(formatData(e[0]['data_cadastro']).replace(" ", " às ").replace(" ", " às "));

        $("#visualizador .lista_opcionais .custom-checkbox").each(function (i) {
            let opcaoChecada = (e.length > 0 && $.inArray($(this).find('input').data('option_id'), e[0]['veiculo_opcionais']) >= 0);
            $(this).find('input').prop('checked', opcaoChecada);
        });

        modal.modal('show');
    });
}

/*Formatando Data*/
function formatData(data, reverse = false) {
    let date = new Date(data);
    formateDate = (reverse) ? data.substr(0, 10).split('/').reverse().join('-') : data.substr(0, 10).split('-').reverse().join('/');

    return  formateDate + " " + data.substr(11, 5);
}

$(document).ready(function () {

    /*Impedindo submissão*/
    submitBlock($('form'));

    /*Iniciando Máscara*/
    inputMask();

    /*Carregando modelos disponíveis*/
    submitPost({
        'url': "search_options.jsp",
        'data': 'tipo=modelo',
        'callSuccess': function (e) {
            modelos = e;
            loads++;
            startApp();
        },
        'callError': function (x, t, e) {
            alert("Erro ao enviar um post ao 'search_options.jsp'");
        }
    });

    /*Carregando opcionais disponíveis*/
    submitPost({
        'url': "search_options.jsp",
        'data': 'tipo=opcionais',
        'callSuccess': function (e) {
            opcionais = e;
            loads++;
            startApp();
        },
        'callError': function (x, t, e) {
            alert("Erro ao enviar um post ao 'search_options.jsp'");
        }
    });

    /*Novo Veículo*/
    $("body").on('click', '.add_veiculo', function () {
        openEditor(null);
    });

    /*Editando Veículo*/
    $("body").on('click', '.editar_veiculo', function () {
        openEditor($(this).closest('tr').data('id'));
        return false;
    });

    /*Visualizando Veículo*/
    $("body").on('click', '.visualizar_veiculo', function () {
        openVisualizador($(this).closest('tr').data('id'));
        return false;
    });

    /*Excluindo Veículo*/
    $("body").on('click', '.excluir_veiculo', function () {
        if (confirm('Tem certeza que deseja excluir este veículo?')) {
            submitPost({
                'url': "excluir_veiculo.jsp",
                'data': "veiculo=" + $(this).closest('tr').data('id'),
                'callSuccess': function (e) {
                    if (e['status'] == undefined || e['status'] != "ok") {
                        alert("Erro ao excluir veículo");
                    } else {
                        redirectTo("index.jsp");
                    }
                },
                'callError': function (x, t, e) {
                    alert("Erro ao enviar um post ao 'excluir_veiculo.jsp'");
                }
            });
        }
        return false;
    });

    /*Buscando veículos*/
    $("body").on('click', '.buscar_veiculos', function () {
        searchVeiculos();
    });

    /*Listando veículos cadastrados*/
    searchVeiculos();

    /*Criando/Atualizando Veículo*/
    $("body").on('click', '.submeter_veiculo', function () {
        let form = $(this).closest('form').serialize();
        $(".alert_editor").slideUp('fast');

        if ($("input[name='valor_venda']").val().length < 4) {
            $(".alert_editor").text("Por favor, preencha corretamente o Valor do Veículo").slideDown('fast');
            return false;
        } else if ($("input[name='placa']").val().length < 8) {
            $(".alert_editor").text("Por favor, preencha corretamente a Placa").slideDown('fast');
            return false;
        } else if ($("input[name='renavam']").val().length < 9) {
            $(".alert_editor").text("Por favor, preencha corretamente o Renavam").slideDown('fast');
            return false;
        }

        let checkboxes = [];
        $(this).closest('form').find('.ck_opcionais').each(function (i, e) {
            if ($(this).is(':checked')) {
                checkboxes.push($(this).val());
            }
        });

        submitPost({
            'url': "register_update.jsp",
            'data': form + "&opcionais=" + checkboxes.join(","),
            'callSuccess': function (e) {
                if (e['status'] == undefined || e['status'] != "ok") {
                    alert("Erro ao criar/atualizar veículo");
                } else {
                    redirectTo("index.jsp");
                }
            },
            'callError': function (x, t, e) {
                alert("Erro ao enviar um post ao 'register_update.jsp'");
            }
        });
    });

});