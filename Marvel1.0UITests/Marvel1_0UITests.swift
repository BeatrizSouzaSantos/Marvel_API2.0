//
//  Marvel1_0UITests.swift
//  Marvel1.0UITests
//
//  Created by user195594 on 5/19/21.
//

import XCTest

class Marvel1_0UITests: XCTestCase {

    override func setUpWithError() throws {
        // Coloque o código de configuração aqui. Este método é chamado antes da invocação de cada método de teste na classe.

        // Em testes de IU, geralmente é melhor parar imediatamente quando ocorre uma falha.
        continueAfterFailure = false

        // Em testes de IU, é importante definir o estado inicial - como a orientação da interface - necessário para seus testes antes de serem executados. O método setUp é um bom exemplo para fazer isso.
    }

    override func tearDownWithError() throws {
        // Coloque o código de desmontagem aqui. Este método é chamado após a invocação de cada método de teste na classe.
    }

    func testExample() throws {
        // Os testes de IU devem iniciar o aplicativo que eles testam.
        let app = XCUIApplication()
        app.launch()

        // Use a gravação para começar a escrever testes de IU.
        // Use o XCTAssert e funções relacionadas para verificar se seus testes produzem os resultados corretos.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // Isso mede quanto tempo leva para iniciar seu aplicativo.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
