/*
 * The MIT License
 *
 * Copyright (c) 2007—2018 NBCO Yandex.Money LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

enum PaymentMethodDataFactory {

    static func decodePaymentMethodData(from decoder: Decoder) -> PaymentMethodData? {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else {
            return nil
        }

        if let data = try? container.decode(PaymentInstrumentDataYandexMoneyLinkedBankCard.self,
                                            forKey: .paymentMethodData) {
            return data
        } else if let data = try? container.decode(PaymentInstrumentDataYandexMoneyWallet.self,
                                                   forKey: .paymentMethodData) {
            return data
        } else if let data = try? container.decode(PaymentMethodDataApplePay.self, forKey: .paymentMethodData) {
            return data
        } else if let data = try? container.decode(PaymentMethodDataSberbank.self, forKey: .paymentMethodData) {
            return data
        } else if let data = try? container.decode(PaymentMethodDataBankCard.self, forKey: .paymentMethodData) {
            return data
        } else if let data = try? container.decode(PaymentMethodData.self, forKey: .paymentMethodData) {
            return data
        } else {
            return nil
        }
    }

    static func encodePaymentMethodData(_ paymentMethodData: PaymentMethodData,
                                        to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch paymentMethodData {
        case let data as PaymentInstrumentDataYandexMoneyLinkedBankCard:
            try container.encode(data, forKey: .paymentMethodData)
        case let data as PaymentInstrumentDataYandexMoneyWallet:
            try container.encode(data, forKey: .paymentMethodData)
        case let data as PaymentMethodDataApplePay:
            try container.encode(data, forKey: .paymentMethodData)
        case let data as PaymentMethodDataSberbank:
            try container.encode(data, forKey: .paymentMethodData)
        case let data as PaymentMethodDataBankCard:
            try container.encode(data, forKey: .paymentMethodData)
        default:
            try container.encode(paymentMethodData, forKey: .paymentMethodData)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case paymentMethodData = "payment_method_data"
    }
}
