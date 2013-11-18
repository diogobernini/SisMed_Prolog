:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_pwp)).

:- prolog_load_context(directory, Dir),	asserta(user:file_search_path(http_demo, Dir)).

user:file_search_path(pwp_dir, http_demo(pwp)).

:- http_handler(root(.), pwp_handler([path_alias(pwp_dir)]), [prefix]).

:- http_handler('/', indice, []).
:- http_handler('/valida_login', valida_login, []).
:- http_handler('/insere_material', insere_material, []).
:- http_handler('/insere_medicamento', insere_medicamento, []).
:- http_handler('/insere_usuario', insere_usuario, []).
:- http_handler('/insere_prontuario', insere_prontuarios, []).
:- http_handler('/insere_paciente', insere_pacientes, []).
:- http_handler('/consulta_material', consulta_material, []).
:- http_handler('/consulta_medicamento', consulta_medicamento, []).
:- http_handler('/consulta_usuario', consulta_usuarios, []).
:- http_handler('/consulta_prontuario', consulta_prontuarios, []).
:- http_handler('/consulta_paciente', consulta_pacientes, []).
:- http_handler('/lista_material', lista_material, []).
:- http_handler('/lista_medicamento', lista_medicamento, []).
:- http_handler('/lista_usuario', lista_usuarios, []).
:- http_handler('/lista_prontuario', lista_prontuarios, []).
:- http_handler('/lista_paciente', lista_pacientes, []).
:- http_handler('/remove_material', remove_material, []).
:- http_handler('/remove_medicamento', remove_medicamento, []).
:- http_handler('/remove_usuario', remove_usuarios, []).
:- http_handler('/remove_prontuario', remove_prontuarios, []).
:- http_handler('/remove_paciente', remove_pacientes, []).
:- http_handler('/imprime_paciente', imprime_paciente, []).

:-dynamic(usuario/6).
:-dynamic(material/6).
:-dynamic(medicamento/6).
:-dynamic(prontuario/17).
:-dynamic(paciente/19).

iniciar:-
	arquivo_assert,
	http_server(http_dispatch, [port(8000)]).

indice(_):-
	http_reply_file('pwp/login.html', [], []).

sucesso_administrador:-
	http_reply_file('pwp/menuAdmin.html',[],[]).

sucesso_enfermeiro:-
	http_reply_file('pwp/menuEnfer.html',[],[]).

sucesso_recepcao:-
	http_reply_file('pwp/menuRecep.html',[],[]).

sucesso_cadastro:-
	http_reply_file('pwp/cadastro-ok.html', [], []).

meta_css:-
        format('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'),
    format('link href="default.css" rel="stylesheet" type="text/css"').

valida_login(Parametros) :-
    http_parameters(Parametros, [
        log_usuario(LogUsuario, [default('')]),
        log_senha(LogSenha, [default('')])
    ]),
    (usuario(_,ID,_, LogUsuario, LogSenha,_) -> ID = ID; ID = 'vazio'),
    (ID == 'vazio' ->
        http_reply_file('pwp/senha_incorreta.html', [], [])
        ;
    ID == '1' ->
        http_reply_file('pwp/menuAdmin.html', [], []);
    ID == '2' ->
        http_reply_file('pwp/menuEnfer.html', [], []);
    ID == '3' ->
        http_reply_file('pwp/menuRecep.html', [], [])
    ).

insere_usuario(Parametros):-
	http_parameters(Parametros, [
	    cargo(UCargo, [default('')]),
	    nome(UNome, [default('')]),
	    usuario(UUsuario, [default('')]),
	    senha(USenha, [default('')]),
	    email(UEmail, [default('')])
				    ]),
	chave_monta('usuarios',Chave),
	arquivo_registro('usuarios',ArqReg),
	append(ArqReg),
	concat_atom([Chave], Key),
	concat_atom([UCargo], Cargo),
	concat_atom([UNome], Nome),
	concat_atom([UUsuario], Usuario),
	concat_atom([USenha], Senha),
	concat_atom([UEmail], Email),
	assert(usuario(Key,Cargo,Nome,Usuario,Senha,Email)),
	write('usuario(\''),
	write(Chave),
	write('\',\''),
	write(UCargo),
	write('\',\''),
	write(UNome),
	write('\',\''),
	write(UUsuario),
	write('\',\''),
	write(USenha),
	write('\',\''),
	write(UEmail),
	write('\'),'),
	nl,
	told,
	sucesso_cadastro.

insere_material(Parametros):-
	http_parameters(Parametros, [
	    descricaomat(Desc, [default('')]),
	    quantidade(Qtd, [default('')]),
	    valorunit(VlU, [default('')]),
	    valortotal(VlT, [default('')]),
	    numsequencial(NSq, [default('')])
				    ]),
	chave_monta('materiais',Chave),
	arquivo_registro('materiais',ArqReg),
	append(ArqReg),
	concat_atom([Chave], Key),
	concat_atom([Desc], Descricao),
	concat_atom([Qtd], Quantidade),
	concat_atom([VlU], ValorUnitario),
	concat_atom([VlT], ValorTotal),
	concat_atom([NSq], NumeroSequencial),
	assert(material(Key,Descricao,Quantidade,ValorUnitario,ValorTotal,NumeroSequencial)),
	write('material(\''),
	write(Chave),
	write('\',\''),
	write(Desc),
	write('\',\''),
	write(Qtd),
	write('\',\''),
	write(VlU),
	write('\',\''),
	write(VlT),
	write('\',\''),
	write(NSq),
	write('\'),'),
	nl,
	told,
	sucesso_cadastro.

insere_medicamento(Parametros):-
	http_parameters(Parametros, [
	    descricaomed(Desc, [default('')]),
	    quantidade(Qtd, [default('')]),
	    valorunit(VlU, [default('')]),
	    valortotal(VlT, [default('')]),
	    numsequencial(NSq, [default('')])
				    ]),
	chave_monta('medicamentos',Chave),
	arquivo_registro('medicamentos',ArqReg),
	append(ArqReg),
	concat_atom([Chave], Key),
	concat_atom([Desc], Descricao),
	concat_atom([Qtd], Quantidade),
	concat_atom([VlU], ValorUnitario),
	concat_atom([VlT], ValorTotal),
	concat_atom([NSq], NumeroSequencial),
	assert(medicamento(Key,Descricao,Quantidade,ValorUnitario,ValorTotal,NumeroSequencial)),
	write('medicamento(\''),
	write(Chave),
	write('\',\''),
	write(Desc),
	write('\',\''),
	write(Qtd),
	write('\',\''),
	write(VlU),
	write('\',\''),
	write(VlT),
	write('\',\''),
	write(NSq),
	write('\'),'),
	nl,
	told,
	sucesso_cadastro.



insere_prontuario(Parametros):-
	http_parameters(Parametros, [
	    paciente(Paciente, [default('')]),
	    dataentrada(DataEntrada, [default('')]),
	    datasaida(DataSaida, [default('')]),
	    horaentrada(HoraEntrada, [default('')]),
	    horasaida(HoraSaida, [default('')]),
	    historicosaude(HistoricoSaude, [default('')]),
            prescricaomedica(PrescricaoMedica, [default('')]),
	    evolucaomedica(EvolucaoMedica, [default('')]),
            prescricaoenfermagem(PrescricaoEnfermagem, [default('')]),
	    evolucaoenfermagem(EvolucaoEnfermagem, [default('')]),
	    anotacoes(Anotacoes, [default('')]),
	    resultadoexames(ResultadoExames, [default('')]),
	    resultadoexamesimagem(ResultadoExamesImagem, [default('')]),
            prescricaonutricionista(PrescricaoNutricionista, [default('')]),
	    evolucaonutricionista(EvolucaoNutricionista, [default('')]),
	    divergencias(Divergencias, [default('')])
				    ]),
	chave_monta('prontuarios',Chave),
	arquivo_registro('prontuarios',ArqReg),
	append(ArqReg),
	concat_atom([Chave], Key),
	concat_atom([Paciente], Pct),
	concat_atom([DataEntrada], DTIN),
	concat_atom([DataSaida], DTOUT),
	concat_atom([HoraEntrada], HRIN),
	concat_atom([HoraSaida], HROUT),
	concat_atom([HistoricoSaude], Hist),
	concat_atom([PrescricaoMedica], PM),
	concat_atom([EvolucaoMedica], EM),
	concat_atom([PrescricaoEnfermagem], PE),
	concat_atom([EvolucaoEnfermagem], EE),
	concat_atom([Anotacoes], Anot),
	concat_atom([ResultadoExames], RE),
	concat_atom([ResultadoExamesImagem], REI),
	concat_atom([PrescricaoNutricionista], PN),
	concat_atom([EvolucaoNutricionista], EN),
	concat_atom([Divergencias], Diver),
	assert(prontuario(Key,Pct,DTIN,DTOUT,HRIN,HROUT,Hist,PM,EM,PE,EE,Anot,RE,REI,PN,EN,Diver)),
	write('prontuario(\''),
	write(Chave),
	write('\',\''),
	write(Paciente),
	write('\',\''),
	write(DataEntrada),
	write('\',\''),
	write(DataSaida),
	write('\',\''),
	write(HoraEntrada),
	write('\',\''),
	write(HoraSaida),
	write('\',\''),
	write(HistoricoSaude),
	write('\',\''),
	write(PrescricaoMedica),
	write('\',\''),
	write(EvolucaoMedica),
	write('\',\''),
	write(PrescricaoEnfermagem),
	write('\',\''),
	write(EvolucaoEnfermagem),
	write('\',\''),
	write(Anotacoes),
	write('\',\''),
	write(ResultadoExames),
	write('\',\''),
	write(ResultadoExamesImagem),
	write('\',\''),
	write(PrescricaoNutricionista),
	write('\',\''),
	write(EvolucaoNutricionista),
	write('\',\''),
	write(Divergencias),
	write('\'),'),
	nl,
	told,
	sucesso_enfermeiro.


insere_paciente(Parametros):-
	http_parameters(Parametros, [
	    nome(Nome, [default('')]),
	    datanascimento(Datanascimento, [default('')]),
	    rg(RG, [default('')]),
	    cpf(CPF, [default('')]),
	    endereco(Endereco, [default('')]),
	    numero(Numero, [default('')]),
	    complemento(Complemento, [default('')]),
	    bairro(Bairro, [default('')]),
	    cidade(Cidade, [default('')]),
	    cep(CEP, [default('')]),
	    estado(Estado, [default('')]),
	    telefone(Telefone, [default('')]),
	    celular(Celular, [default('')]),
	    pessoaresponsavel(PResponsavel, [default('')]),
	    telefoneresponsavel(TelResponsavel, [default('')]),
	    cpfresponsavel(CPFResponsavel, [default('')]),
	    convenio(Convenio, [default('')]),
	    observacoes(Obs, [default('')])
				    ]),
	chave_monta('pacientes',Chave),
	arquivo_registro('pacientes',ArqReg),
	append(ArqReg),
	concat_atom([Chave], Key),
	concat_atom([Nome], Nomee),
	concat_atom([Datanascimento], Dataa),
	concat_atom([RG], RGG),
	concat_atom([CPF], CPFF),
	concat_atom([Endereco], Enderecoo),
	concat_atom([Numero], Numeroo),
	concat_atom([Complemento], Complementoo),
	concat_atom([Bairro], Bairroo),
	concat_atom([Cidade], Cidadee),
	concat_atom([CEP], CEPP),
	concat_atom([Estado], Estadoo),
        concat_atom([Telefone], Telefonee),
	concat_atom([Celular], Celularr),
	concat_atom([PResponsavel], PResponsavell),
	concat_atom([TelResponsavel], TelResponsavell),
	concat_atom([CPFResponsavel], CPFResponsavell),
	concat_atom([Convenio], Convenioo),
	concat_atom([Obs], Obss),
	assert(paciente(Key,Nomee,Dataa,RGG,CPFF,Enderecoo,Numeroo,Complementoo,Bairroo,Cidadee,CEPP,Estadoo,Telefonee,Celularr,PResponsavell,TelResponsavell,CPFResponsavell,Convenioo,Obss)),
	write('usuario(\''),
	write(Chave),
	write('\',\''),
	write(Nome),
	write('\',\''),
	write(Datanascimento),
	write('\',\''),
	write(RG),
	write('\',\''),
	write(CPF),
	write('\',\''),
	write(Endereco),
	write('\',\''),
	write(Numero),
	write('\',\''),
	write(Complemento),
	write('\',\''),
	write(Bairro),
	write('\',\''),
	write(Cidade),
	write('\',\''),
	write(CEP),
	write('\',\''),
	write(Estado),
	write('\',\''),
	write(Telefone),
	write('\',\''),
	write(Celular),
	write('\',\''),
	write(PResponsavel),
	write('\',\''),
	write(TelResponsavel),
	write('\',\''),
	write(CPFResponsavel),
	write('\',\''),
	write(Convenio),
	write('\',\''),
	write(Obs),
	write('\'),'),
	nl,
	told,
	sucesso_recepcao.

arquivo_registro(Arquivo, ArqReg):-
    concat_atom(['registros/', Arquivo, '.txt'], ArqReg).

chave_monta(Arquivo, Chave):-
    concat_atom(['chaves/', Arquivo, '.txt'], Full_path),
    open(Full_path, read, F),
    chave_leitura(F, Key),
    close(F),
    [Chave|_] = Key,
    NewKey is Chave + 1,
    tell(Full_path),
    write('chave('),
    write(NewKey),
    write(').'),
    told.

chave_leitura(F, []):-
    at_end_of_stream(F).

chave_leitura(F, [Key|L]):-
    \+ at_end_of_stream(F),
    read(F, chave(Key)),
    chave_leitura(F, L).

arquivo_assert:-
    arquivo_percorre_lista(['materiais','medicamentos','pacientes','usuarios','prontuarios']).

arquivo_percorre_lista([]).

arquivo_percorre_lista([Arquivo|Lista]):-
    arquivo_registro(Arquivo, ArqReg),
    open(ArqReg, read, F),
    arquivo_leitura(F),
    close(F),
    arquivo_percorre_lista(Lista).

arquivo_leitura(F):-
    at_end_of_stream(F).

arquivo_leitura(F):-
    \+ at_end_of_stream(F),
    read(F, Registro),
    assert(Registro),
    arquivo_leitura(F).


