# bd_project
Домашнее задание

```mermaid
erDiagram
    REGION ||--o{ CLIENT : "размещается в"
    REGION ||--o{ SUPPLIER : "зарегистрирован в"
    
    CLIENT ||--o{ ORDER : "оформляет"
    ORDER ||--o{ ORDER_ITEM : "содержит"
    ORDER_ITEM }o--|| PRODUCT : "указывает"
    
    SUPPLIER ||--o{ PART_SUPP : "поставляет"
    PRODUCT ||--o{ PART_SUPP : "поставляется в"

    PRODUCT ||--o{ PRODUCT_VERSION : "имеет версии"
    }

```
