## PayStand Ruby Library

### Setup

```ruby
require './lib/paystand'

PayStand.configure do |config|
  config.client_id = ''
  config.client_secret = ''
  config.publishable_key = ''
  config.platform_customer_id = ''
  config.log_enabled = false
  config.env = :production # it could be sandbox/dev
end
```

### Code examples

#### Create a transaction on a customer (not the platform)

```ruby
card = {
  name_on_card: "Jane Doe",
  card_number: "4000000000000077",
  security_code: "123",
  expiration_month: "11",
  expiration_year: "2018",
  billing_address: {
    name: "Jane Doe",
    street1: "123 test st",
    city: "santa cruz",
    state: "CA",
    postal_code: "95060",
    country: "USA"
  }
}

params = {
  card: card,
  amount: 20.00,
  currency: 'USD',
}

payment = PayStand::Payment.create(params)
```

##### Create a payment transfer:

```ruby
params[:transfer_type] = 'advanced'
params[:transfers] = {
  'merchant_key_1' => {
    'account_key_1' => {
      final: 1.00,
    },
    'account_key_2' => {
      final: 2.00,
    }
  },
  'owner' => {
    default: {
      final: 6.00
    }
  }
}
response = PayStand::Payment.create(child_customer_id, params)

```

#### Get the balance of a customer

```ruby
child_customer_id = '8467x11b5qwfn4fv4byauf6g'
balance = PayStand::Balance.list(child_customer_id)
```

#### Create a customer


```ruby
address = {
  street1: "123 account st",
  city: "Los Angeles",
  state: "CA",
  postal_code: "12345",
  country: "USA"
}
bank = {
  name_on_account: "Martha Flowers",
  account_holder_type: "company",
  account_number: "000123456789",
  routing_number: "110000000",
  account_type: "checking",
  country: "USA",
  currency: "USD"
}
customer = {
  name: "John Doe",
  email: "example@example.com",
  address: address,
  plan_key: 'my_plan_key',
  merchant_key: 'child_customer_sub',
  legal_entity: {
    entity_type: "LLC",
    years_in_business: "5",
    business_name: "Martha's Flowers",
    business_tax_id: "000000000",
    business_sales_volume: "2000",
    business_accepted_cards: true,
    personal_tax_id: "000000000",
    stake_percent: "100"
  },
  contact: {
    first_name: "Martha",
    last_name: "Flowers",
    email: "martha@example.com",
    phone: "8312223333",
    date_of_birth: "08-30-1984"
  },
  merchant: {
    business_name: "Martha's FLowers",
    business_url: "http://www.example.com",
    business_logo: "http://www.example.com/images/flowers.jpg",
    support_email: "support@example.com",
    support_phone: "8317778888",
    support_url: "http://www.example.com"
  },
  default_bank: bank
}
customer_created = PayStand::Customer.create(customer)
new_customer_id = customer_created.account.id
```

#### Retrieve a customer

```ruby

customer_created = PayStand::Customer.retrieve(new_customer_id)

```

#### Update a customer

```ruby
customer_created = PayStand::Customer.update(new_customer_id, {merchant_key: 'child_customer_sub' })
```

#### Create an account

```ruby
account = {
  name: "My Account",
  key: "my_account",
}
response = PayStand::BalanceAccount.create(account)
```

### TODOs:

* Support maintaining a session with refreshing the token.
