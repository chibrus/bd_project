CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE nations (
    nation_id SERIAL PRIMARY KEY,
    region_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_nation_region FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    nation_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_nation FOREIGN KEY (nation_id) REFERENCES nations(nation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    order_priority VARCHAR(50),
    cleark VARCHAR(255),
    ship_priority INT,
    comment TEXT,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    nation_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    acct_bal DECIMAL(10,2),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_supplier_nation FOREIGN KEY (nation_id) REFERENCES nations(nation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE parts (
    part_id SERIAL PRIMARY KEY,
    region_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    mf_gr VARCHAR(100),
    brand VARCHAR(100),
    type VARCHAR(100),
    size INT,
    container VARCHAR(50),
    retail_price DECIMAL(10,2),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_part_region FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE parts_versions (
    part_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    mf_gr VARCHAR(100),
    brand VARCHAR(100),
    type VARCHAR(100),
    size INT,
    container VARCHAR(50),
    retail_price DECIMAL(10,2),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    version INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE,
    PRIMARY KEY (part_id, version),
    CONSTRAINT fk_parts_versions FOREIGN KEY (part_id) REFERENCES parts(part_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE part_supps (
    part_supp_id SERIAL PRIMARY KEY,
    supplier_id INT NOT NULL,
    part_id INT NOT NULL,
    avail_qty INT NOT NULL,
    supply_cost DECIMAL(10,2) NOT NULL,
    comment TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_part_supp_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_part_supp_part FOREIGN KEY (part_id) REFERENCES parts(part_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE line_items (
    line_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    part_supp_id INT NOT NULL,
    line_number INT NOT NULL,
    quantity INT NOT NULL,
    extended_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2),
    tax DECIMAL(5,2),
    return_flag CHAR(1),
    line_status CHAR(1),
    ship_date DATE NOT NULL,
    commit_date DATE NOT NULL,
    receipt_date DATE NOT NULL,
    ship_instruct TEXT,
    ship_mode VARCHAR(50),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_line_item_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_line_item_part_supp FOREIGN KEY (part_supp_id) REFERENCES part_supps(part_supp_id) ON DELETE CASCADE ON UPDATE CASCADE
);
