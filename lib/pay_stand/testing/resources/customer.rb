module PayStand
  class Customer < Resource
    def self.create(params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.create :customer, default.merge(params)
    end

    def self.update(id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.update :customer, id, default.merge(params)
    end

    def self.retrieve(id)
      return super unless PayStand::Testing.enabled?

      Data.instance.retrieve :customer, id
    end

    def self.default
      bank = Data.instance.create :bank, Bank.default
      address = {
        city: 'santa cruz',
        country: 'USA',
        postalCode: '90040',
        state: 'CA',
        street1: '923 test account st',
      }
      contact = {
        date_of_birth: '08-30-1984',
        email: 'jane@example.com',
        first_name: 'Jane',
        last_name: 'Doe',
        phone: '8312223333',
      }
      legal_entity = {
        business_name: 'Example customer',
        business_sales_volume: '2000',
        business_tax_id: '000000000',
        entity_type: 'LLC',
        personal_tax_id: '000000000',
        stake_percent: '100',
        years_in_business: '5',
      }
      merchant = {
        business_logo: 'http://www.example.com/logo.jpg',
        business_name: 'Example customer',
        business_url: 'http://www.example.com',
        support_email: 'support@example.com',
        support_phone: '8317778888',
        support_url: 'http://www.example.com',
      }
      {
        address: address,
        contact: contact,
        default_bank: bank,
        email: 'example@example.com',
        legal_entity: legal_entity,
        merchant: merchant,
        merchant_key: 'example_merchant_key',
        name: 'Example customer',
        plan_key: 'hint_health_standard',
      }
    end
  end
end
