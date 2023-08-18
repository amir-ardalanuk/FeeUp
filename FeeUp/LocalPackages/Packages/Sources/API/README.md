## API Module
The API Module serves as a network wrapper that implements endpoints and ultimately prepares the required data for the upper layer module.

## Role
This module interacts solely with the Network and Domain modules.
When implementing any API call, it is necessary to define all the requirements—such as endpoint requests, request and response models—within this module. It is responsible for serializing data for output or raising errors for the upper layer.