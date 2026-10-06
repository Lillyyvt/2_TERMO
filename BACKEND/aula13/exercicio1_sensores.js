// Exercício 1: Registro de Sensores Industriais
// Contexto: Uma célula de manufatura automatizada precisa registrar os parâmetros de 3 sensores de temperatura e
// pressão instalados em um reator.
// Requisitos:
// Criar arquivo exercicio1_sensores.js.
// Definir array com 3 objetos contendo: codigo (inteiro), tipo ("Temperatura" / "Pressão"), leituraAtual
// (decimal) e status ("Operando" / "Alerta").
// Converter com indentação de 2 espaços e gravar fisicamente em sensores.json.
// Exibir mensagem de sucesso no terminal ao finalizar.

const fs = require('fs');

const sensores = [
    { codigo: 1001, tipo: "Temperatura", leituraAtual: 85.4, status: "Operando" },
    { codigo: 1002, tipo: "Pressão", leituraAtual: 6.2, status: "Operando" },
    { codigo: 1003, tipo: "Temperatura", leituraAtual: 102.7, status: "Alerta" }
];

const dadosJSON = JSON.stringify(sensores, null, 2);
fs.writeFileSync('sensores.json', dadosJSON);

console.log("Arquivo 'sensores.json' gerado com sucesso.");
