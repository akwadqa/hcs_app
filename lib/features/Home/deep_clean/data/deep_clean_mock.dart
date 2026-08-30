const deepCleanMockResponse = {
  "status_code": 200,
  "message": "ok",
  "data": [
    {
      "id": "deep_cleaning",
      "name": "Deep Cleaning",
      "description": "Full deep clean of the property",
      "fields": [
        {
          "key": "property_type",
          "label": "Property Type",
          "type": "dropdown",
          "required": true,
          "hint": "Apartment",
          "options": [
            {"id": "apartment", "label": "Apartment"},
            {"id": "villa",     "label": "Villa"}
          ]
        },
        {
          "key": "area",
          "label": "Area",
          "type": "dropdown",
          "required": true,
          "hint": "Up to 100 m²",
          "depends_on": "property_type",
          "options_by_parent": {
            "apartment": [
              {"id": "a_100",  "label": "Up to 100 m²",       "price": 250},
              {"id": "a_150",  "label": "101 - 150 m²",       "price": 350},
              {"id": "a_200",  "label": "151 - 200 m²",       "price": 450},
              {"id": "a_quote","label": "Over 300 m² - Quote","is_quote": true}
            ],
            "villa": [
              {"id": "v_200",  "label": "Up to 200 m²",        "price": 600},
              {"id": "v_500",  "label": "301 - 500 m²",        "price": 900},
              {"id": "v_700",  "label": "501 - 700 m²",        "price": 1200},
              {"id": "v_1000", "label": "701 - 1000 m²",       "price": 1500},
              {"id": "v_quote","label": "Over 1000 m² - Quote","is_quote": true}
            ]
          }
        }
      ]
    },
    {
      "id": "pest_control",
      "name": "Pest Control",
      "fields": [
        {
          "key": "pest_type",
          "label": "Pest Type",
          "type": "dropdown",
          "options": [
            {"id": "cockroaches", "label": "Cockroaches"},
            {"id": "bedbugs",     "label": "Bed Bugs"},
            {"id": "rodents",     "label": "Rodents"},
            {"id": "termites",    "label": "Termites"}
          ]
        },
        {
          "key": "property_type",
          "label": "Property Type",
          "type": "dropdown",
          "options": [
            {"id": "apartment", "label": "Apartment"},
            {"id": "villa",     "label": "Villa"}
          ]
        },
        {"key": "rooms_count", "label": "Number of Rooms", "type": "number", "hint": "e.g. 3"}
      ]
    },
    {
      "id": "sofa_upholstery",
      "name": "Sofa and Upholstery",
      "fields": [
        {"key": "seats", "label": "Number of Seats", "type": "number", "hint": "e.g. 5"},
        {
          "key": "material",
          "label": "Material",
          "type": "dropdown",
          "options": [
            {"id": "fabric",  "label": "Fabric"},
            {"id": "leather", "label": "Leather"},
            {"id": "suede",   "label": "Suede"}
          ]
        }
      ]
    },
    {
      "id": "water_tank",
      "name": "Water Tank Cleaning",
      "fields": [
        {
          "key": "tank_size",
          "label": "Tank Size",
          "type": "dropdown",
          "options": [
            {"id": "small",  "label": "Small (up to 1000 L)",   "price": 150},
            {"id": "medium", "label": "Medium (1000 - 3000 L)", "price": 250},
            {"id": "large",  "label": "Large (over 3000 L)",    "price": 400}
          ]
        },
        {"key": "tanks_count", "label": "Number of Tanks", "type": "number"}
      ]
    },
    {
      "id": "post_construction",
      "name": "Post-Construction Cleaning",
      "fields": [
        {
          "key": "property_type",
          "label": "Property Type",
          "type": "dropdown",
          "options": [
            {"id": "apartment", "label": "Apartment"},
            {"id": "villa",     "label": "Villa"},
            {"id": "office",    "label": "Office"}
          ]
        },
        {"key": "area_sqm", "label": "Total Area (m²)", "type": "number"},
        {"key": "notes",    "label": "Additional Notes","type": "text", "required": false}
      ]
    }
  ]
};