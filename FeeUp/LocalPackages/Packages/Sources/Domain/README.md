
## Domain Module
The Domain Module serves as the low-level component responsible for defining pure entities and use cases. Here, we have the option to divide this module into two separate modules, namely Entity and UseCases, to adhere closely to the principles of the Clean Architecture. However, for the purpose of this sample usage, maintaining the current structure suffices.

### Roles
When introducing a new feature to the application, it is essential to initiate the process by defining the requirements within this module. Subsequently, the implementation of the logic can be carried out in other modules such as Network and Persistence.

The key aspect to emphasize is that this module must remain independent, without being aware of the existence of other modules