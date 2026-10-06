// Exercício 3: Histórico de Inspeção de Qualidade com Validação de Lote
// Contexto: Um inspetor de qualidade afere a espessura de 4 chapas de aço. O sistema compila as medições e valida a
// tolerância técnica do lote.
// Requisitos:
// Criar arquivo exercicio3_inspecao.js.
// Estruturar o objeto relatorioInspecao com: data ("2026-09-23"), inspetor (nome), amostras (array de 4
// números em mm) e loteAprovado (booleano).
// O lote só é aprovado se todas as medidas forem ≥ 12.0 mm.
// Converter para JSON e salvar no arquivo inspecao_qualidade.json, emitindo veredito no console.

const fs = require('fs');

const amostrasColetadas = [12.1, 12.3, 11.9, 12.0];

// Verifica se todas as amostras atendem ao critério mínimo de 12.0 mm
let aprovado = true;
for (let i = 0; i < amostrasColetadas.length; i++) {
    if (amostrasColetadas[i] < 12.0) {
        aprovado = false;
        break;
    }
}

const relatorioInspecao = {
    data: "2026-09-23",
    inspetor: "Carlos Eduardo",
    amostras: amostrasColetadas,
    loteAprovado: aprovado
};

fs.writeFileSync('inspecao_qualidade.json', JSON.stringify(relatorioInspecao, null, 2));

console.log("=== RELATÓRIO DE QUALIDADE GERADO ===");
console.log(`Status do Lote: ${aprovado ? "APROVADO" : "REPROVADO"}`);
console.log("Arquivo 'inspecao_qualidade.json' gravado com sucesso.");