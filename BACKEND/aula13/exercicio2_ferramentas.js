// Exercício 2: Cadastro de Ferramental com Entrada Dinâmica
// Contexto: A ferramentaria precisa registrar ferramentas manuais interativamente pelo terminal e consolidar o lote no
// disco.
// Requisitos:
// Criar arquivo exercicio2_ferramentas.js e utilizar a biblioteca readline-sync.
// Perguntar quantas ferramentas serão registradas e iterar via laço for.
// Para cada ferramenta, solicitar: nome (string), quantidade (inteiro) e custoUnitario (float), inserindo no array
// via .push().
// Persistir os dados em ferramentas.json e exibir confirmação com contagem de itens.

const fs = require('fs');
const entrada = require('readline-sync');

console.log("=== CADASTRO DE FERRAMENTAS ===");
const totalItens = entrada.questionInt("Quantas ferramentas deseja cadastrar? ");
const listaFerramentas = [];

for (let i = 0; i < totalItens; i++) {
    console.log(`\nItem ${i + 1} de ${totalItens}:`);
    const nome = entrada.question("Nome da ferramenta: ");
    const quantidade = entrada.questionInt("Quantidade: ");
    const custoUnitario = entrada.questionFloat("Custo unitario (R$): ");

    listaFerramentas.push({
        nome: nome,
        quantidade: quantidade,
        custoUnitario: custoUnitario
    });
}

fs.writeFileSync('ferramentas.json', JSON.stringify(listaFerramentas, null, 2));

console.log("\n==================================");
console.log(`Sucesso: ${listaFerramentas.length} itens gravados em 'ferramentas.json'.`);
console.log("==================================");