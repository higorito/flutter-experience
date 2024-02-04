Para executar, por enquanto deve-se:

fe_clinicas_api
```
jrs run
```
Esse comando vai iniciar o json rest server com os dados de teste.

fe_clinicas_self_service
```
dart pub run build_runner watch -d
```
Esse iniciara a observação e vai gerar o FACTORY utilizado nos models de pacientes com o pacote json_annotation

Por fim observe os args do .vscode na pasta fe_clinicas_self_service
