# Ticketing System API

The REST API allows Users to purchase Tickets for various Events.

---

## Setup

1.  Install gems:

         $ bundle install

2.  Setup database:

         $ rake db:create
         $ rake db:migrate

3.  Seed the database:

         $ rake db:seed

---

## Docs

- See `/doc/api/index.html` for API documentation.
- Documentation created with the use of the rspec_api_documentation gem.

---

## Architecture

- API versioned under v1

      https://example.com/api/v1/

- Tickets nest under particular Event
- User can have many Tickets

---

## Notes

- List of available endpoints to be found in API documentation.

### API-only Rails app

Application is currently configured as an API-only Rails application. Depending on the future front-end implementation, there might be a necessity to convert the application into a regular 'base' app in order to utilize the view layer.

### Authentication

Due to API-only app character with future FE in mind, the authentication has not been developed into a working state.

Current devise gem inclusion with devise-generated User model allows for quick session-based authentication implementation once front-end is present.
If the application is to remain in API only state, Token authentication is a feasible solution.

I have intentionally skipped the Token-based authentication this time, however, I have some experience in Bearer Token per devise_token_auth gem implementation in the past.
Currently, authenticate_user! method in controllers is commented out.

### Ticket purchase

Ticket purchase has been naively implemented with the use of a provided adapter.

The current solution allows for single ticket purchase (multiple tickets purchase not-available).

The charge_payment method uses mocked payment service response, having a 33% chance to succeed, 66% to return payment error. Please see tickets_controller#create for reference.

Final implementation should make use of the Stipe'alike payment system presented over the front end.

### Tests

Tests implemented using RSpec.

Unavailability of current_user helper method without working auth lead to couple test workarounds, these are pointed out with relevant comments inside specs.

User resource request tests not implemented, auth-dependant.

Events/Tickets tests up and running.

Acceptance tests serve the sole purpose of documentation generation.

### Ticket dependent: :destroy

Current deletion of an Event / User leads into chain destroy action on associated Tickets.

Final implementation should store invalidated Tickets after Event / User deletion.

### Custom show action json schemas

All resources have a little tweaked #show response to present more user-friendly information.

---

## Maintenance

Run tests

    rspec

Rebuild API documentation

    $ rake docs:generate

---
