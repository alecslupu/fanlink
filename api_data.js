define({ "api": [
  {
    "type": "post",
    "url": "/badge_actions",
    "title": "Create a badge action.",
    "name": "CreateBadgeAction",
    "group": "Badges",
    "description": "<p>This creates a badge action. A badge action is a record of something done of a particular action type in the app. Badge actions are earned toward unearned badges of the action type matching the badge action. This call returns either an array of earned badges or an object called pending_badge with the points earned so far and the badge info. If more than one badge has been partially earned, the badge with the highest percentage earned is returned.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "badge_action",
            "description": "<p>The badge_action object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "badge_action.action_type",
            "description": "<p>The internal name of the badge action.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "badge_action.identifier",
            "description": "<p>The identifier for this badge action.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\nbadges_awarded: { [badge json], [badge_json],...} OR\npending_badge: { //NULL if there are no pending badges\n    badge_action_count: 1,\n    badge: [ badge json]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Action type invalid, cannot do that action again, blah blah blah\" }\nHTTP/1.1 429 - Not enough time since last submission of this action type\n      or duplicate action type, person, identifier combination",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/badge_actions_controller.rb",
    "groupTitle": "Badges"
  },
  {
    "type": "get",
    "url": "/badges",
    "title": "Get badges for a passed in user.",
    "name": "GetBadges",
    "group": "Badges",
    "description": "<p>This gets a list of all badges earned for a passed in user. Will include points earned towards each badge and whether badge has been awarded to the user.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "person_id",
            "description": "<p>The id of the person whose badges you want.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"pending_badges\": [\n  {\n    badge_action_count: 1,\n    badge_awarded: false,\n    badge: {\n      \"id\": 123,\n      \"name\": \"Sheriff\",\n      \"internal_name\": \"sheriff\",\n      \"description\": \"You get this badge for just existing, in true millennial fashion\",\n      \"picture_url\": \"http://example.com/images/14,\n      \"action_requirement\": 1,\n      \"point_value\": 5\n    }\n  },...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/badges_controller.rb",
    "groupTitle": "Badges"
  },
  {
    "type": "patch",
    "url": "/product_beacons/:id",
    "title": "Update a beacon",
    "name": "BeaconUpdate",
    "group": "Beacons",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product_internal_name",
            "description": "<p>Internal name of the product</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "product_beacon",
            "description": "<p>The product beacon container</p>"
          },
          {
            "group": "Parameter",
            "type": "UUID",
            "optional": true,
            "field": "product_beacon.uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "product_beacon.lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "product_beacon.upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "product_beacon.attached_to",
            "description": "<p>The activity the beacon is attached to.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"product_beacon\": {\n        \"attached_to\": 1\n    }\n}",
          "type": "type"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "beacon",
            "description": "<p>The response beacon container</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.id",
            "description": "<p>Beacon ID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.product_id",
            "description": "<p>Product ID the beacon is registered to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "beacon.beacon_pid",
            "description": "<p>The beacon product id located on the box</p>"
          },
          {
            "group": "200",
            "type": "UUID",
            "optional": false,
            "field": "uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.attached_to",
            "description": "<p>The activity the beacon is attached to. Can be null.</p>"
          },
          {
            "group": "200",
            "type": "Datetime",
            "optional": false,
            "field": "beacon.created_at",
            "description": "<p>The date and time the beacon was added to the database.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"beacon\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"beacon_pid\": \"A12FC4-12912\",\n        \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n        \"lower\": \"25\",\n        \"upper\": \"75\",\n        \"attachd_to\": \"\",\n        \"created_at\": \"2018-05-09T21:52:48.653Z\"\n    }\n}",
          "type": "type"
        }
      ]
    },
    "filename": "app/controllers/api/v1/product_beacons_controller.rb",
    "groupTitle": "Beacons"
  },
  {
    "type": "post",
    "url": "/product_beacons",
    "title": "Add a beacon to a product",
    "name": "CreateBeacon",
    "group": "Beacons",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "product_beacon",
            "description": "<p>The product beacon container</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product_beacon.beacon_pid",
            "description": "<p>The Beacon's product id listed on the box</p>"
          },
          {
            "group": "Parameter",
            "type": "UUID",
            "optional": false,
            "field": "product_beacon.uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "product_beacon.lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "Parameter",
            "type": "Nummber",
            "optional": false,
            "field": "product_beacon.upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "attached_to",
            "description": "<p>The activity the beacon is attached to.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"url\" : \"https://api.example.com/product_beacons\"\n}",
          "type": "Url"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "beacon",
            "description": "<p>Returns the newly created beacon</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.id",
            "description": "<p>Beacon ID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.product_id",
            "description": "<p>Product ID the beacon is registered to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "beacon.beacon_pid",
            "description": "<p>The beacon product id located on the box</p>"
          },
          {
            "group": "200",
            "type": "UUID",
            "optional": false,
            "field": "beacon.uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.attached_to",
            "description": "<p>The activity the beacon is attached to. Can be null.</p>"
          },
          {
            "group": "200",
            "type": "Datetime",
            "optional": false,
            "field": "beacon.created_at",
            "description": "<p>The date and time the beacon was added to the database.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"beacon\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"beacon_pid\": \"A12FC4-12912\",\n        \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n        \"lower\": \"25\",\n        \"upper\": \"75\",\n        \"attachd_to\": \"\",\n        \"created_at\": \"2018-05-09T21:52:48.653Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/product_beacons_controller.rb",
    "groupTitle": "Beacons"
  },
  {
    "type": "delete",
    "url": "/product_beacons/:id",
    "title": "title",
    "name": "DeleteBeacon",
    "group": "Beacons",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product_internal_name",
            "description": "<p>Internal name of the product</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"id\" : \"https://api.example.com/product_beacons/1\",\n    \"pid\": \"https://api.example.com/product_beacons/abcdef-123456\"\n}",
          "type": "type"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Header",
            "optional": false,
            "field": "header",
            "description": "<p>Returns a 200 response if successful</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK",
          "type": "Header"
        }
      ]
    },
    "filename": "app/controllers/api/v1/product_beacons_controller.rb",
    "groupTitle": "Beacons"
  },
  {
    "type": "get",
    "url": "/beacons/:id",
    "title": "Get Beacon by id or it's product id",
    "name": "GetBeacon",
    "group": "Beacons",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of beacon</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"id\" : \"https://api.example.com/product_beacons/1\",\n    \"pid\": \"https://api.example.com/product_beacons/abcdef-123456\"\n}",
          "type": "Url"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "beacon",
            "description": "<p>The product beacon object</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.id",
            "description": "<p>Beacon ID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.product_id",
            "description": "<p>Product ID the beacon is registered to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "beacon.beacon_pid",
            "description": "<p>The beacon product id located on the box</p>"
          },
          {
            "group": "200",
            "type": "UUID",
            "optional": false,
            "field": "beacon.uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacon.attached_to",
            "description": "<p>The activity the beacon is attached to. Can be null.</p>"
          },
          {
            "group": "200",
            "type": "Datetime",
            "optional": false,
            "field": "beacon.created_at",
            "description": "<p>The date and time the beacon was added to the database.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"beacon\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"beacon_pid\": \"A12FC4-12912\",\n        \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n        \"lower\": \"25\",\n        \"upper\": \"75\",\n        \"attachd_to\": \"\",\n        \"created_at\": \"2018-05-09T21:52:48.653Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/product_beacons_controller.rb",
    "groupTitle": "Beacons"
  },
  {
    "type": "get",
    "url": "/beacons/list",
    "title": "Get a list of all beacons.",
    "name": "GetBeaconsList",
    "group": "Beacons",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"url\": \"https://api.example.com/product_beacons/list\"\n}",
          "type": "url"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "beacons",
            "description": "<p>A list of all the beacons</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.id",
            "description": "<p>Beacon ID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.product_id",
            "description": "<p>Product ID the beacon is registered to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "beacons.beacon_pid",
            "description": "<p>The beacon product id located on the box</p>"
          },
          {
            "group": "200",
            "type": "UUID",
            "optional": false,
            "field": "beacons.uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "beacons.deleted",
            "description": "<p>Is set to true if a beacon has been soft deleted.</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.attached_to",
            "description": "<p>The activity the beacon is attached to. Can be null.</p>"
          },
          {
            "group": "200",
            "type": "Datetime",
            "optional": false,
            "field": "beacons.created_at",
            "description": "<p>The date and time the beacon was added to the database.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "{\n    \"beacons\": [\n      \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"beacon_pid\": \"A12FC4-12912\",\n        \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n        \"lower\": \"25\",\n        \"upper\": \"75\",\n        \"attached_to\": null,\n        \"created_at\": \"2018-05-09T21:52:48.653Z\"\n   ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/product_beacons_controller.rb",
    "groupTitle": "Beacons"
  },
  {
    "type": "get",
    "url": "/beacons",
    "title": "Beacons for a product",
    "name": "ProductBeacons",
    "group": "Beacons",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"url\": \"https://api.example.com/beacons\"\n}",
          "type": "url"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "beacons",
            "description": "<p>Beacons container</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.id",
            "description": "<p>Beacon ID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.product_id",
            "description": "<p>Product ID the beacon is registered to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "beacons.beacon_pid",
            "description": "<p>The beacon product id located on the box</p>"
          },
          {
            "group": "200",
            "type": "UUID",
            "optional": false,
            "field": "beacons.uuid",
            "description": "<p>Beacon UUID</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.lower",
            "description": "<p>Lower</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.upper",
            "description": "<p>Upper</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "beacons.attached_to",
            "description": "<p>The activity the beacon is attached to. Can be null.</p>"
          },
          {
            "group": "200",
            "type": "Datetime",
            "optional": false,
            "field": "beacons.created_at",
            "description": "<p>The date and time the beacon was added to the database.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "{\n    \"beacons\": [\n      \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"beacon_pid\": \"A12FC4-12912\",\n        \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n        \"lower\": \"25\",\n        \"upper\": \"75\",\n        \"attached_to\": null,\n        \"created_at\": \"2018-05-09T21:52:48.653Z\"\n   ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/product_beacons_controller.rb",
    "groupTitle": "Beacons"
  },
  {
    "type": "post",
    "url": "/blocks",
    "title": "Block a person.",
    "name": "CreateBlock",
    "group": "Blocks",
    "description": "<p>This is used to block a person. When a person is blocked, any followings and relationships are immediately removed between the users.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "block",
            "description": "<p>Block object.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "block.blocked_id",
            "description": "<p>Person current user wants to block</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"block\": {\n  \"id\" : 123, #id of the block\n  \"blocker_id\" : 1,\n  \"blocked_id\" : 2\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"You already blocked that person, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/blocks_controller.rb",
    "groupTitle": "Blocks"
  },
  {
    "type": "delete",
    "url": "/blocks/:id",
    "title": "Unblock a person.",
    "name": "DeleteBlock",
    "group": "Blocks",
    "description": "<p>This is used to unblock a person.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "id",
            "description": "<p>id of the underlying block</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 if block not found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/blocks_controller.rb",
    "groupTitle": "Blocks"
  },
  {
    "type": "get",
    "url": "/events/:id",
    "title": "Get a single event.",
    "name": "GetEvent",
    "group": "Events",
    "description": "<p>This gets a single event for an event id.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"event\": [\n  {\n    \"id\": \"5016\",\n    \"name\": \"Some event\",\n    \"description\": \"Some more about the event\"\n    \"starts_at\": \"2018-01-08T12:00:00Z\",\n    \"ends_at\":  \"2018-01-08T15:00:00Z\",\n    \"ticket_url\": \"https://example.com/3455455\",\n    \"place_identifier\": \"fdA3434Bdfad34134\"\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/events_controller.rb",
    "groupTitle": "Events"
  },
  {
    "type": "get",
    "url": "/events",
    "title": "Get available events.",
    "name": "GetEvents",
    "group": "Events",
    "description": "<p>This gets a list of events, in starts_at order.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "from_date",
            "description": "<p>Only include events starting on or after date in format &quot;YYYY-MM-DD&quot;. Note valid dates start from 2017-01-01.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "to_date",
            "description": "<p>Only include events starting on or before date in format &quot;YYYY-MM-DD&quot;. Note valid dates start from 2017-01-01.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"events\": [\n  { ....event json..see get single event action ....\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401 Unauthorized",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/events_controller.rb",
    "groupTitle": "Events"
  },
  {
    "type": "post",
    "url": "/followings",
    "title": "Follow a person.",
    "name": "CreateFollowing",
    "group": "Following",
    "description": "<p>This is used to follow a person.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "followed_id",
            "description": "<p>Person to follow</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"following\": {\n  \"id\" : 123, #id of the following\n  \"follower\" : { ...public json of the person following },\n  \"followed\" : { ...public json of the person followed }\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/followings_controller.rb",
    "groupTitle": "Following"
  },
  {
    "type": "delete",
    "url": "/followings/:id",
    "title": "Unfollow a person.",
    "name": "DeleteFollowing",
    "group": "Following",
    "description": "<p>This is used to unfollow a person.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "id",
            "description": "<p>id of the underlying following</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/followings_controller.rb",
    "groupTitle": "Following"
  },
  {
    "type": "get",
    "url": "/followings",
    "title": "Get followers or followings of a user.",
    "name": "GetFollowings",
    "group": "Following",
    "description": "<p>This is used to get a list of someone's followers or followed. If followed_id parameter is supplied, it will get the follower's of that user. If follower_id is supplied, it will get the people that person is following. If nothing is supplied, it will get the people the current user is following.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "followed_id",
            "description": "<p>Person to who's followers to get</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "follower_id",
            "description": "<p>Id of person who is following the people in the list we are getting.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 Ok\n\"followers [or following]\" {\n  [ ... person json of follower/followed....],\n  ....\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/followings_controller.rb",
    "groupTitle": "Following"
  },
  {
    "type": "get",
    "url": "/levels",
    "title": "Get all available levels.",
    "name": "GetLevels",
    "group": "Level",
    "description": "<p>This gets a list of all levels available to be obtained.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"levels\": [\n  {\n    \"id\": \"123\"\n    \"name\": \"Level One\",\n    \"internal_name\": \"level_one\",\n    \"description\": \"some level translated to current language\",\n    \"points\": 10,\n    \"picture_url\": \"http://example.com/images/14\"\n  },...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/levels_controller.rb",
    "groupTitle": "Level"
  },
  {
    "type": "get",
    "url": "/merchandise/:id",
    "title": "Get a single piece of merchandise.",
    "name": "GetMerchandise",
    "group": "Merchandise",
    "description": "<p>This gets a single piece of merchandise for a merchandise id.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"merchandise\": [\n  {\n    \"id\": \"5016\",\n    \"name\": \"Something well worth the money\",\n    \"description\": \"Bigger than a breadbox\"\n    \"price\": \"$4.99\",\n    \"purchase_url\": \"https://amazon.com/3455455\",\n    \"picture_url\": \"https://example.com/hot.jpg\"\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/merchandise_controller.rb",
    "groupTitle": "Merchandise"
  },
  {
    "type": "get",
    "url": "/merchandise",
    "title": "Get available merchandise.",
    "name": "GetMerchandise",
    "group": "Merchandise",
    "description": "<p>This gets a list of merchandise, in priority order.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"merchandise\": [\n  { ....merchandise json..see get single merchandise action ....\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401 Unauthorized",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/merchandise_controller.rb",
    "groupTitle": "Merchandise"
  },
  {
    "type": "post",
    "url": "/rooms/{room_id}/messages",
    "title": "Create a message in a room.",
    "name": "CreateMessage",
    "group": "Messages",
    "description": "<p>This creates a message in a room and posts it to Firebase as appropriate.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "message",
            "description": "<p>The message object container for the message parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "message.body",
            "description": "<p>The body of the message.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "message.picture",
            "description": "<p>Message picture, this should be <code>image/gif</code>, <code>image/png</code>, or <code>image/jpeg</code>.</p>"
          },
          {
            "group": "Parameter",
            "type": "Array",
            "optional": true,
            "field": "mentions",
            "description": "<p>Array of mentions each consisting of required person_id (integer), location (integer) and length (integer)</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\nmessage: { ..message json..see get message action ....}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Body is required, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "post",
    "url": "/rooms/:room_id/message_reports",
    "title": "Report a message in a public room.",
    "name": "CreateMessageReport",
    "group": "Messages",
    "description": "<p>This reports a message that was posted to a public room.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "room_id",
            "optional": false,
            "field": "room_id",
            "description": "<p>Id of the room in which the message was created.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "message_report",
            "description": "<p>The message report object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "message_report.message_id",
            "description": "<p>The id of the message being reported.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "message_report.reason",
            "description": "<p>The reason given by the user for reporting the message.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"I don't like your reason, etc.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/message_reports_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "delete",
    "url": "/rooms/{room_id}/messages/id",
    "title": "Delete (hide) a single message.",
    "name": "DeleteMessage",
    "group": "Messages",
    "description": "<p>This deletes a single message by marking as hidden. Can only be called by the creator.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 401 Unauthorized, etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "get",
    "url": "/rooms/{room_id}/messages/id",
    "title": "Get a single message.",
    "name": "GetMessage",
    "group": "Messages",
    "description": "<p>This gets a single message for a message id. Only works for messages in private rooms. If the message author has been blocked by the current user, this will return 404 Not Found.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"message\":\n  {\n    \"id\": \"5016\",\n    \"body\": \"Stupid thing to say\",\n    \"created_time\": \"2018-01-08T12:13:42Z\"\n    \"picture_url\": \"http://host.name/path\",\n    \"person\": {...public person json with relationships...}\n  }",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "get",
    "url": "/message_reports",
    "title": "Get list of messages reports (ADMIN).",
    "name": "GetMessageReports",
    "group": "Messages",
    "description": "<p>This gets a list of message reports with optional filter.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "status_filter",
            "description": "<p>If provided, valid values are &quot;message_hidden&quot;, &quot;no_action_needed&quot;, and &quot;pending&quot;</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"message_reports\": [\n  {\n    \"id\": \"1234\",\n    \"created_at\": \"2018-01-08'T'12:13:42'Z\",\n    \"updated_at\": \"2018-01-08'T'12:13:42'Z\",\n    \"message_id\": 1234,\n    \"poster\": \"message_username\",\n    \"reporter\": \"message_report_username\",\n    \"reason\": \"I don't like your message\",\n    \"status\": \"pending\"\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/message_reports_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "get",
    "url": "/rooms/{room_id}/messages",
    "title": "Get messages.",
    "name": "GetMessages",
    "group": "Messages",
    "version": "2.0.0",
    "description": "<p>This gets a list of messages for a page number and a per page parameter.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "page",
            "description": "<p>Page number to get.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Number of messages in a page. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "pinned",
            "description": "<p>&quot;Yes&quot; to provide only pinned messages, &quot;No&quot; to provide only non-pinned messages. &quot;All&quot; (default) for all regardless of pinned status.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"messages\": [\n  { ....message json..see get message action ....\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v2/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "get",
    "url": "/rooms/{room_id}/messages",
    "title": "Get messages.",
    "name": "GetMessages",
    "group": "Messages",
    "version": "1.0.0",
    "description": "<p>This gets a list of message for a from date, to date, with an optional limit. Messages are returned newest first, and the limit is applied to that ordering.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "from_date",
            "description": "<p>From date in format &quot;YYYY-MM-DD&quot;. Note valid dates start from 2017-01-01.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "to_date",
            "description": "<p>To date in format &quot;YYYY-MM-DD&quot;. Note valid dates start from 2017-01-01.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "limit",
            "description": "<p>Limit results to count of limit.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"messages\": [\n  { ....message json..see get message action ....\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "get",
    "url": "/messages",
    "title": "Get a list of messages without regard to room (ADMIN ONLY).",
    "name": "ListMessages",
    "group": "Messages",
    "description": "<p>This gets a list of messages without regard to room (with possible exception of room filter).</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "id_filter",
            "description": "<p>Full match on Message id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person_filter",
            "description": "<p>Full or partial match on person username.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "room_id_filter",
            "description": "<p>Full match on Room id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "body_filter",
            "description": "<p>Full or partial match on message body.</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "reported_filter",
            "description": "<p>Filter on whether the message has been reported.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>Page number. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Messages per page. Default is 25.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"messages\": [\n  {\n    \"id\": \"123\",\n    \"person_id\": 123,\n    \"room_id\": 123,\n    \"body\": \"Do you like my body?\",\n    \"hidden\": false,\n    \"picture_url\": \"http://example.com/pic.jpg\",\n    \"created_at\": \"2018-01-08'T'12:13:42'Z'\",\n    \"updated_at\": \"2018-01-08'T'12:13:42'Z'\"\n  },...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401 Unautorized",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "patch",
    "url": "/messages/{id}",
    "title": "Update a message",
    "name": "UpdateMessage",
    "group": "Messages",
    "description": "<p>This updates a message in a room. Only the hidden field can be changed and only by an admin. If the item is hidden, Firebase will be updated to inform the app that the message has been hidden.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "message",
            "description": "<p>The message object container for the message parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": false,
            "field": "message.hidden",
            "description": "<p>Whether or not the item is hidden.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\nmessage: { ..message json..see list messages action ....}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401, 404",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/messages_controller.rb",
    "groupTitle": "Messages"
  },
  {
    "type": "patch",
    "url": "/people/:id/change_password",
    "title": "Change your password.",
    "name": "ChangePassword",
    "group": "People",
    "description": "<p>This is used to change the logged in user's password.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "ObjectId",
            "optional": false,
            "field": "id",
            "description": "<p>The person id.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "person",
            "description": "<p>The person's information.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "person.current_password",
            "description": "<p>Current password.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.new_password",
            "description": "<p>New password.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok or 422",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/people_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "post",
    "url": "/notification_device_ids",
    "title": "Add a new device id for a person.",
    "name": "CreateNotificationDeviceId",
    "group": "People",
    "description": "<p>This adds a new device id to be used for notifications to the Firebase Cloud Messaging Service. A user can have any number of device ids.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "device_id",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Device ID already registered\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/notification_device_ids_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "post",
    "url": "/people/password_forgot",
    "title": "Initiate a password reset.",
    "name": "CreatePasswordReset",
    "group": "People",
    "description": "<p>This is used to initiate a password reset. Product and email or username required. If email or username is not found, password reset will fail silently.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product",
            "description": "<p>Internal name of product</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "email_or_username",
            "description": "<p>The person's email or username.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"message\": {\n  \"Reset password instructions have been sent to your email, if it exists in our system\"\n}, or\nHTTP/1.1 422 Unprocessable\n\"errors\": { //if product not found\n  \"Required parameter missing.\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/password_resets_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "post",
    "url": "/people",
    "title": "Create person.",
    "name": "CreatePerson",
    "group": "People",
    "description": "<p>This is used to create a new person.</p> <p>If they account creation is successful, they will be logged in and we will send an onboarding email (if we have an email address for them).</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product",
            "description": "<p>Internal name of product</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "person",
            "description": "<p>The person's information.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "person.email",
            "description": "<p>Email address (required unless using FB auth token).</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "facebook_auth_token",
            "description": "<p>Auth token from Facebook</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.name",
            "description": "<p>Name.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "person.username",
            "description": "<p>Username. This needs to be unique within product scope.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "person.password",
            "description": "<p>Password.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "person.picture",
            "description": "<p>Profile picture, this should be <code>image/gif</code>, <code>image/png</code>, or <code>image/jpeg</code>.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.gender",
            "description": "<p>Gender. Valid options: unspecified (default), male, female</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.birthdate",
            "description": "<p>Birth dateTo date in format &quot;YYYY-MM-DD&quot;.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.city",
            "description": "<p>Person's supplied city.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.country_code",
            "description": "<p>Alpha2 code (two letters) from ISO 3166 list.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"person\": { // The full private version of the person (person json with email).\n  ....see show action for person json...,\n  \"email\" : \"foo@example.com\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/people_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "delete",
    "url": "/notification_device_ids",
    "title": "Delete a device id",
    "name": "DeleteNotificationDeviceId",
    "group": "People",
    "description": "<p>This deletes a single device id. Can only be called by the owner.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "device_id",
            "description": ""
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/notification_device_ids_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "get",
    "url": "/people",
    "title": "Get a list of people.",
    "name": "GetPeople",
    "group": "People",
    "description": "<p>This is used to get a list of people.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>Page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Page division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "username_filter",
            "description": "<p>A username or username fragment to filter on.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "email_filter",
            "description": "<p>An email or email fragment to filter on.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"people\": [\n    {...see show action for person json....},....\n ]",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/people_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "get",
    "url": "/people/:id",
    "title": "Get a person.",
    "name": "GetPerson",
    "group": "People",
    "description": "<p>This is used to get a person.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "ObjectId",
            "optional": false,
            "field": "id",
            "description": "<p>The id of the person you want.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"person\": {\n  \"id\": \"5016\",\n  \"username\": \"Pancakes.McGee\",\n  \"name\": \"Pancakes McGee\",\n  \"picture_url\": \"http://host.name/path\",\n  \"product_account\": false,\n  \"recommended\": false,\n  \"chat_banned\": false,\n  \"designation\": \"Grand Poobah\",\n  \"following_id\": 12, //or null\n  \"num_followers\": 0,\n  \"num_following\": 0,\n  \"relationships\": [ {json for each relationship}], //only present if relationships present\n  \"badge_points\": 0,\n  \"role\": \"normal\",\n  \"level\": {...level json...}, //or null,\n  \"do_not_message_me\": false,\n  \"pin_messages_from\": false,\n  \"auto_follow\": false,\n  \"facebookid\": 'fadfasdfa',\n  \"facebook_picture_url\": \"facebook.com/zuck_you.jpg\"\n  \"created_at\": \"2018-03-12T18:55:30Z\",\n  \"updated_at\": \"2018-03-12T18:55:30Z\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/people_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "get",
    "url": "/people/recommended",
    "title": "Get recommended people.",
    "name": "GetRecommendedPeople",
    "group": "People",
    "description": "<p>This is used to get a list of people flagged as 'recommended'. It excludes the current user and anyone the current user is following.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 Ok\n\"recommended_people\" {\n  [ ... person json ...],\n  ....\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/recommended_people_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "post",
    "url": "/people/password_reset",
    "title": "Completes a password reset.",
    "name": "UpdatePasswordReset",
    "group": "People",
    "description": "<p>This is used to complete a password reset. It takes a form submitted from fan.link</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>Token from email link</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "password",
            "description": "<p>The new password.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok; or\nHTTP/1.1 422 Unprocessable\n\"errors\": { //if token/person not found or password bad\n  \"...be better blah blah....\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/password_resets_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "put | patch",
    "url": "/people/:id",
    "title": "Update person.",
    "name": "UpdatePerson",
    "group": "People",
    "description": "<p>This is used to update a person. Anything not mentioned is left alone.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "ObjectId",
            "optional": false,
            "field": "id",
            "description": "<p>The person id.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "person",
            "description": "<p>The person's information.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.email",
            "description": "<p>Email address.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.name",
            "description": "<p>Full name.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.username",
            "description": "<p>Username. This needs to be unique.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "person.picture",
            "description": "<p>Profile picture, this should be <code>image/gif</code>, <code>image/png</code>, or <code>image/jpeg</code>.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.gender",
            "description": "<p>Gender. Valid options: unspecified (default), male, female</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.birthdate",
            "description": "<p>Birth dateTo date in format &quot;YYYY-MM-DD&quot;.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.city",
            "description": "<p>Person's supplied city.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person.country_code",
            "description": "<p>Alpha2 code (two letters) from ISO 3166 list.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"person\": { // The full private version of the person.\n  ...see create action....\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/people_controller.rb",
    "groupTitle": "People"
  },
  {
    "type": "post",
    "url": "/posts",
    "title": "Create a post.",
    "name": "CreatePost",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This creates a post and puts in on the feed of the author's followers.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post",
            "description": "<p>The post object container for the post parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.body",
            "description": "<p>The body of the message.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "post.picture",
            "description": "<p>Post picture, this should be <code>image/gif</code>, <code>image/png</code>, or <code>image/jpeg</code>.</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "post.global",
            "description": "<p>Whether the post is global (seen by all users).</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.starts_at",
            "description": "<p>When the post should start being visible (same format as in responses).</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.ends_at",
            "description": "<p>When the post should stop being visible (same format as in responses).</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "post.repost_interval",
            "description": "<p>How often this post should be republished.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.status",
            "description": "<p>Valid values: &quot;pending&quot;, &quot;published&quot;, &quot;deleted&quot;, &quot;rejected&quot;</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "post.priority",
            "description": "<p>Priority value for post.</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "post.recommended",
            "description": "<p>(Admin) Whether the post is recommended.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\npost: { ..post json..see get post action ....}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Body is required, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "post",
    "url": "/posts/:id/comments",
    "title": "Create a comment on a post.",
    "name": "CreatePostComment",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This creates a post comment. It is automatically attributed to the logged in user.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_comment",
            "description": "<p>The post_comment object container for the post_comment parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "post_comment.body",
            "description": "<p>The body of the comment.</p>"
          },
          {
            "group": "Parameter",
            "type": "Array",
            "optional": true,
            "field": "mentions",
            "description": "<p>Mentions in the comment.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "mention.person_id",
            "description": "<p>The id of the person mentioned.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "mention.location",
            "description": "<p>Where the mention text starts in the comment.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "mention.length",
            "description": "<p>The length of the mention text.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\npost_comment: {\n  \"id\": 1234,\n  \"body\": \"Do you like my body?\",\n  \"mentions\": [\n    {\n      \"person_id\": 1234,\n      \"location\": 1,\n      \"length\": 1\n    },...\n  ]\n  \"person\": { person json }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Body is required, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/post_comments_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "post",
    "url": "/posts/:post_id/reactions",
    "title": "React to a post.",
    "name": "CreatePostReaction",
    "group": "Posts",
    "description": "<p>This reacts to a post.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "post_id",
            "description": "<p>The id of the post to which you are reacting</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_reaction",
            "description": "<p>The post reaction object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "post_reaction.reaction",
            "description": "<p>The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 Ok\npost_reaction {\n  \"id\": \"1234\",\n  \"person_id\": 1234,\n  \"post_id\": 1234,\n  \"reaction\": \"1F601\"\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"I don't like your reaction, etc.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_reactions_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "post",
    "url": "/post_reports",
    "title": "Report a post.",
    "name": "CreatePostReport",
    "group": "Posts",
    "description": "<p>This reports a post that was posted to a feed.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_report",
            "description": "<p>The post report object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "post_report.post_id",
            "description": "<p>The id of the post being reported.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post_report.reason",
            "description": "<p>The reason given by the user for reporting the post.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"I don't like your reason, etc.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_reports_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "post",
    "url": "/post_comment_reports",
    "title": "Report a post comment.",
    "name": "CreatePostReportComment",
    "group": "Posts",
    "description": "<p>This reports a post comment.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_comment_report",
            "description": "<p>The post report object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "post_comment_report.post_comment_id",
            "description": "<p>The id of the post comment being reported.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post_comment_report.reason",
            "description": "<p>The reason given by the user for reporting the post comment.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"I don't like your reason, etc.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_comment_reports_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "delete",
    "url": "/posts/:id",
    "title": "Delete (hide) a single post.",
    "name": "DeletePost",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This deletes a single post by marking as deleted. Can only be called by the creator.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 401 Unauthorized, etc.",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "delete",
    "url": "/posts/:post_id/comments/:id",
    "title": "Delete a comment on a post.",
    "name": "DeletePostComment",
    "group": "Posts",
    "description": "<p>This deletes a comment on a post. Can be performed by admin or creator of comment.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "post_id",
            "description": "<p>The id of the post to which the comment relates</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "id",
            "description": "<p>The id of the post comment you are deleting</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_comments_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "delete",
    "url": "/posts/:post_id/reactions/:id",
    "title": "Delete a reaction to a post.",
    "name": "DeletePostReaction",
    "group": "Posts",
    "description": "<p>This deletes a reaction to a post.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "post_id",
            "description": "<p>The id of the post to which you are reacting</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "id",
            "description": "<p>The id of the post reaction you are updating</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_reactions_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts/:id",
    "title": "Get a single post.",
    "name": "GetPost",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This gets a single post for a post id.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"post\": {\n  \"id\": \"1234\",\n  \"create_time\":\"2018-02-18T06:32:24Z\",\n  \"body\":\"post body\",\n  \"picture_url\": \"www.example.com/pic.jpg\",\n  \"person\": ....public person json...,\n  \"post_reaction_counts\":{\"1F389\":1},\n  \"post_reaction\":...see post reaction create json....(or null if current user has not reacted)\n  \"global\": false,\n  \"starts_at\":  \"2018-01-01T00:00:00Z\",\n  \"ends_at\":    \"2018-01-31T23:59:59Z\",\n  \"repost_interval\": 0,\n  \"status\": \"published\",\n  \"priority\": 0,\n  \"recommended\": false\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/post_comment_reports",
    "title": "Get list of post comment reports (ADMIN).",
    "name": "GetPostCommentReports",
    "group": "Posts",
    "description": "<p>This gets a list of post comment reports with optional filter.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>Page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Page division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "status_filter",
            "description": "<p>If provided, valid values are &quot;pending&quot;, &quot;no_action_needed&quot;, and &quot;comment_hidden&quot;</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"post_comment_reports\": [\n  {\n    \"id\": \"1234\",\n    \"created_at\": \"2018-01-08T12:13:42Z\",\n    \"post_comment_id\": 1234,\n    \"commenter\": \"post_comment_username\",\n    \"reporter\": \"post_comment_report_username\",\n    \"reason\": \"I don't like your comment\",\n    \"status\": \"pending\"\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_comment_reports_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts/:id/comments",
    "title": "Get the comments on a post.",
    "name": "GetPostComments",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This gets all the non-hidden comments on a post with pagination.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"post_comments\": [\n  {\n    ...post comment json..see create action ...\n  }, ...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/post_comments_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/post_reports",
    "title": "Get list of post reports (ADMIN).",
    "name": "GetPostReports",
    "group": "Posts",
    "description": "<p>This gets a list of post reports with optional filter.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>Page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Page division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "status_filter",
            "description": "<p>If provided, valid values are &quot;pending&quot;, &quot;no_action_needed&quot;, and &quot;post_hidden&quot;</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"post_reports\": [\n  {\n    \"id\": \"1234\",\n    \"created_at\": \"2018-01-08T12:13:42Z\",\n    \"post_id\": 1234,\n    \"poster\": \"post_username\",\n    \"reporter\": \"post_report_username\",\n    \"reason\": \"I don't like your post\",\n    \"status\": \"pending\"\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_reports_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts",
    "title": "Get paginated posts.",
    "name": "GetPosts",
    "group": "Posts",
    "version": "2.0.0",
    "description": "<p>This gets a list of posts for a page and an amount per page. Posts are returned newest first. Posts included are posts from the passed in person or, if none, the current user along with those of the users the current user is following.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "person_id",
            "description": "<p>The person whose posts to get. If not supplied, posts from current user plus those from people the current user is following will be returned.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>Page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Number of posts in a page. Default is 25.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"posts\": [\n  { ....post json..see get post action ....\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v2/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts",
    "title": "Get posts for a date range.",
    "name": "GetPosts",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This gets a list of posts for a from date, to date, with an optional limit and person. Posts are returned newest first, and the limit is applied to that ordering. Posts included are posts from the passed in person or, if none, the current user along with those of the users the current user is following.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "person_id",
            "description": "<p>The person whose posts to get. If not supplied, posts from current user plus those from people the current user is following will be returned.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "from_date",
            "description": "<p>From date in format &quot;YYYY-MM-DD&quot;. Note valid dates start from 2017-01-01.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "to_date",
            "description": "<p>To date in format &quot;YYYY-MM-DD&quot;. Note valid dates start from 2017-01-01.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "limit",
            "description": "<p>Limit results to count of limit.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"posts\": [\n  { ....post json..see get post action ....\n  },....\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found, 422 Unprocessable, etc.",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts/recommended",
    "title": "Get recommended posts.",
    "name": "GetRecommendedPosts",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This is used to get a list of published posts flagged as 'recommended'.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>Page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>Page division. Default is 25.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 Ok\n\"recommended_posts\" {\n  [ ... post json ...],\n  ....\n}",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/recommended_posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts/:id/share",
    "title": "Get a single, shareable post.",
    "name": "GetShareablePost",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This gets a single post for a post id without authentication.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product",
            "description": "<p>Product internal name.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"post\": {\n    \"body\": \"Stupid thing to say\",\n    \"picture_url\": \"http://host.name/path\",\n    \"person\": {\n        \"username\": Tester McTestingson,\n        \"picture_url\": \"http://host.name/path\"\n     },\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/post_comments/list",
    "title": "Get a list of post comments (ADMIN).",
    "name": "ListPostComments",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This gets a list of post comments with optional filters and pagination.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "body_filter",
            "description": "<p>Full or partial match on comment body.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person_filter",
            "description": "<p>Full or partial match on person username or email.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"post_comments\": [\n  {\n    \"id\": \"123\",\n    \"post_id\": 3,\n    \"person_id\": 123,\n    \"body\": \"Do you like my body?\",\n    \"hidden\": false,\n    \"created_at\": \"2017-12-31T12:13:42Z\",\n    \"updated_at\": \"2017-12-31T12:13:42Z\"\n    \"mentions\": [\n      {\n        \"person_id\": 1,\n        \"location\": 1,\n        \"length\": 3\n      }, ...\n    ]\n  },...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401 Unauthorized",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/post_comments_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "get",
    "url": "/posts/list",
    "title": "Get a list of posts (ADMIN ONLY).",
    "name": "ListPosts",
    "group": "Posts",
    "version": "1.0.0",
    "description": "<p>This gets a list of posts with optional filters and pagination.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "id_filter",
            "description": "<p>Full match on post.id. Will return either a one element array or an empty array.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "person_id_filter",
            "description": "<p>Full match on person id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person_filter",
            "description": "<p>Full or partial match on person username or email.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "body_filter",
            "description": "<p>Full or partial match on post body.</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "posted_after_filter",
            "description": "<p>Posted at or after timestamp. Format: &quot;2018-01-08T12:13:42Z&quot;</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "posted_before_filter",
            "description": "<p>Posted at or before timestamp. Format: &quot;2018-01-08T12:13:42Z&quot;</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "status_filter",
            "description": "<p>Post status. Valid values: pending published deleted rejected errored</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"posts\": [\n  {\n    \"id\": \"123\",\n    \"person_id\": 123,\n    \"body\": \"Do you like my body?\",\n    \"picture_url\": \"http://example.com/pic.jpg\",\n    \"global\": false,\n    \"starts_at\":  \"2018-01-01T00:00:00Z\",\n    \"ends_at\":    \"2018-01-31T23:59:59Z\",\n    \"repost_interval\": 0,\n    \"status\": \"published\",\n    \"priority\": 0,\n    \"recommended\": false,\n    \"created_at\": \"2017-12-31T12:13:42Z\",\n    \"updated_at\": \"2017-12-31T12:13:42Z\"\n  },...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401 Unauthorized",
          "type": "json"
        }
      ]
    },
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "patch",
    "url": "/posts/{id}",
    "title": "Update a post (ADMIN)",
    "name": "UpdatePost",
    "group": "Posts",
    "description": "<p>This updates a post.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post",
            "description": "<p>The post object container for the post parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.body",
            "description": "<p>The body of the post.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "post.picture",
            "description": "<p>Post picture, this should be <code>image/gif</code>, <code>image/png</code>, or <code>image/jpeg</code>.</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "post.global",
            "description": "<p>Whether the post is global (seen by all users).</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.starts_at",
            "description": "<p>When the post should start being visible (same format as in responses).</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.ends_at",
            "description": "<p>When the post should stop being visible (same format as in responses).</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "post.repost_interval",
            "description": "<p>How often this post should be republished.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "post.status",
            "description": "<p>Valid values: &quot;pending&quot;, &quot;published&quot;, &quot;deleted&quot;, &quot;rejected&quot;</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "post.priority",
            "description": "<p>Priority value for post.</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "post.recommended",
            "description": "<p>(Admin) Whether the post is recommended.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\npost: { ..post json..see list posts action ....}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401, 404",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/posts_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "patch",
    "url": "/post_reports/:id",
    "title": "Update a Post Comment Report (Admin).",
    "name": "UpdatePostCommentReport",
    "group": "Posts",
    "description": "<p>This updates a post comment report. The only value that can be changed is the status.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "id",
            "optional": false,
            "field": "id",
            "description": "<p>URL parameter. id of the post comment report you want to update.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_comment_report",
            "description": "<p>The post report object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "status",
            "optional": false,
            "field": "post_comment_report.status",
            "description": "<p>The new status. Valid statuses are &quot;pending&quot;, &quot;no_action_needed&quot;, &quot;comment_hidden&quot;</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Invalid or missing status.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_comment_reports_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "post",
    "url": "/posts/:post_id/reactions/:id",
    "title": "Update a reaction to a post.",
    "name": "UpdatePostReaction",
    "group": "Posts",
    "description": "<p>This updates a reaction to a post.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "post_id",
            "description": "<p>The id of the post to which you are reacting</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "id",
            "description": "<p>The id of the post reaction you are updating</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_reaction",
            "description": "<p>The post reaction object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "post_reaction.reaction",
            "description": "<p>The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 Ok\npost_reaction {\n  \"id\": \"1234\",\n  \"person_id\": 1234,\n  \"post_id\": 1234,\n  \"reaction\": \"1F601\"\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"I don't like your new reaction either, etc.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_reactions_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "patch",
    "url": "/post_reports/:id",
    "title": "Update a Post Report.",
    "name": "UpdatePostReport",
    "group": "Posts",
    "description": "<p>This updates a post report. The only value that can be changed is the status.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "id",
            "optional": false,
            "field": "id",
            "description": "<p>URL parameter. id of the post report you want to update.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "post_report",
            "description": "<p>The post report object container.</p>"
          },
          {
            "group": "Parameter",
            "type": "status",
            "optional": false,
            "field": "post_report.status",
            "description": "<p>The new status. Valid statuses are &quot;pending&quot;, &quot;no_action_needed&quot;, &quot;post_hidden&quot;</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"Invalid or missing status.\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/post_reports_controller.rb",
    "groupTitle": "Posts"
  },
  {
    "type": "post",
    "url": "/quests/:id/activities",
    "title": "Create quest activity",
    "name": "CreateQuestActivity",
    "group": "QuestActivities",
    "version": "1.0.0",
    "description": "<p>Create a quest activity</p>",
    "permission": [
      {
        "name": "admin"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "number",
            "optional": false,
            "field": "id",
            "description": "<p>Quest ID</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "quest_activity",
            "description": "<p>Container for the quest activity fields</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "description",
            "description": "<p>A description of the requirements for the activity</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "hint",
            "description": "<p>Optional hint text</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "post",
            "description": "<p>Boolean for whether or not the activity requires a post</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "image",
            "description": "<p>Boolean for whether or not the activity requires an image to be attached</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "audio",
            "description": "<p>Boolean for whether or not the activity requires an audio file</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "beacon",
            "description": "<p>Beacon attached to the activity</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "actvity_code",
            "description": "<p>The code required to enable the activity</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "step",
            "description": "<p>Used to order the activities. Multiple activities can share the same step</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "curl",
            "optional": false,
            "field": "quest_activity",
            "description": "<p>Returns the create quest activity</p> <p>curl -X POST <br> http://localhost:3000/quests/1/activities <br> -H 'Accept: application/vnd.api.v2+json' <br> -H 'Accept-Language: en' <br> -H 'Cache-Control: no-cache' <br> -H 'Content-Type: multipart/form-data' <br> -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' <br> -F 'quest_activity[description]=Escape to Boston' <br> -F 'quest_activity[hint]=Find the glasses' <br> -F 'quest_activity[beacon]=1' <br> -F 'quest_activity[activity_code]=293812' <br> -F 'quest_activity[step]=0' <br> -F 'quest_activity[picture]=undefined'</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "{\n  \"activity\": {\n    \"id\": \"1\",\n    \"quest_id\": \"1\",\n    \"description\": \"Break into the museum\",\n    \"hint\": \"Don't get caught\",\n    \"picture_url\": \"https://example.com/hi.jpg\",\n    \"picture_width\": 1920,\n    \"picture_height\": 1080,\n    \"post\": false,\n    \"image\": false,\n    \"audio\": false,\n    \"beacon\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"beacon_pid\": \"A12FC4-12912\",\n        \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n        \"lower\": \"25\",\n        \"upper\": \"75\",\n        \"created_at\": \"2018-05-14T08:12:25.042Z\"\n    },\n    \"activity_code\": \"983213\",\n    \"step\": 0,\n    \"created_at\": \"2018-05-14T08:12:32.419Z\"\n  }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_activities_controller.rb",
    "groupTitle": "QuestActivities"
  },
  {
    "type": "get",
    "url": "/quests/:id/activities",
    "title": "Get Quest Activities",
    "name": "GetQuestActivities",
    "group": "QuestActivities",
    "version": "1.0.0",
    "description": "<p>Retrieve all activities for a given quest</p>",
    "permission": [
      {
        "name": "user"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>Quest ID</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X GET \\\nhttp://localhost:3000/quests/1/activities \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "curl"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quest_activities",
            "description": "<p>An array of activity objects</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"activities\": [\n        {\n            \"id\": \"1\",\n            \"quest_id\": \"1\",\n            \"description\": \"Break into the museum\",\n            \"hint\": \"Got Caught! Again!\",\n            \"picture_url\": \"https://example.com/hi.jpg\",\n            \"picture_width\": 1920,\n            \"picture_height\": 1080,\n            \"post\": false,\n            \"image\": false,\n            \"audio\": false,\n            \"beacon\": {\n                \"id\": \"1\",\n                \"product_id\": \"1\",\n                \"beacon_pid\": \"A12FC4-12912\",\n                \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n                \"lower\": \"25\",\n                \"upper\": \"75\",\n                \"created_at\": \"2018-05-14T08:12:25.042Z\"\n            },\n            \"activity_code\": \"23813921\",\n            \"step\": 0,\n            \"created_at\": \"2018-05-14T08:12:32.419Z\"\n        }\n    ]\n}",
          "type": "Object[]"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_activities_controller.rb",
    "groupTitle": "QuestActivities"
  },
  {
    "type": "get",
    "url": "/activities/:id",
    "title": "Get a quest activity",
    "name": "GetQuestActivity",
    "group": "QuestActivities",
    "version": "1.0.0",
    "description": "<p>Retrieve a single quest activity from the database</p>",
    "permission": [
      {
        "name": "user"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>Activity ID</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X GET \\\nhttp://localhost:3000/activities/1 \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "Url"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "activity",
            "description": "<p>Activity Object</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"activity\": {\n        \"id\": \"1\",\n        \"quest_id\": \"1\",\n        \"description\": \"Break into the museum\",\n        \"hint\": \"Don't get caught\",\n        \"picture_url\": \"https://example.com/hi.jpg\",\n        \"picture_width\": 1920,\n        \"picture_height\": 1080,\n        \"post\": false,\n        \"image\": false,\n        \"audio\": false,\n        \"beacon\": {\n            \"id\": \"1\",\n            \"product_id\": \"1\",\n            \"beacon_pid\": \"A12FC4-12912\",\n            \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n            \"lower\": \"25\",\n            \"upper\": \"75\",\n            \"created_at\": \"2018-05-14T08:12:25.042Z\"\n        },\n        \"activity_code\": \"23813921\",\n        \"step\": 0,\n        \"created_at\": \"2018-05-14T08:12:32.419Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_activities_controller.rb",
    "groupTitle": "QuestActivities"
  },
  {
    "type": "delete",
    "url": "/activities/:id",
    "title": "Destroy a quest activity",
    "name": "QuestActivityDestroy",
    "group": "QuestActivities",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>Activity id</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X DELETE \\\nhttp://localhost:3000/activities/1 \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "curl"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Header",
            "optional": false,
            "field": "header",
            "description": "<p>200 OK header response</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK",
          "type": "Header"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_activities_controller.rb",
    "groupTitle": "QuestActivities"
  },
  {
    "type": "patch",
    "url": "/activities/:id",
    "title": "Update a quest activity",
    "name": "QuestActivityUpdate",
    "group": "QuestActivities",
    "version": "1.0.0",
    "description": "<p>Update a quest activity with optional fields</p>",
    "permission": [
      {
        "name": "admin"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of activity to update</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "quest_activity",
            "description": "<p>Container for the quest activity fields</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "description",
            "description": "<p>A description of the requirements for the activity</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "hint",
            "description": "<p>Optional hint text</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "post",
            "description": "<p>Boolean for whether or not the activity requires a post</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "image",
            "description": "<p>Boolean for whether or not the activity requires an image to be attached</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "audio",
            "description": "<p>Boolean for whether or not the activity requires an audio file</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "beacon",
            "description": "<p>Beacon attached to the activity</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "activity_code",
            "description": "<p>The code required to enable the activity</p>"
          },
          {
            "group": "Parameter",
            "type": "int",
            "optional": false,
            "field": "step",
            "description": "<p>Used to order the activities. Multiple activities can share the same step</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X PATCH \\\nhttp://localhost:3000/activities/1 \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache' \\\n-H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \\\n-F 'quest_activity[beacon]=2'",
          "type": "curl"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "quest_activity",
            "description": "<p>Returns the updated quest activity</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"activity\": {\n        \"id\": \"1\",\n        \"quest_id\": \"1\",\n        \"description\": \"Break into the museum\",\n        \"hint\": \"Got Caught! Again!\",\n        \"picture_url\": \"https://example.com/hi.jpg\",\n        \"picture_width\": 1920,\n        \"picture_height\": 1080,\n        \"post\": false,\n        \"image\": false,\n        \"audio\": false,\n        \"beacon\": {\n            \"id\": \"1\",\n            \"product_id\": \"1\",\n            \"beacon_pid\": \"A12FC4-12912\",\n            \"uuid\": \"eae4c812-bcfb-40e8-9414-b5b42826dcfb\",\n            \"lower\": \"25\",\n            \"upper\": \"75\",\n            \"created_at\": \"2018-05-14T08:12:25.042Z\"\n        },\n        \"activity_code\": \"23813921\",\n        \"step\": 0,\n        \"created_at\": \"2018-05-14T08:12:32.419Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_activities_controller.rb",
    "groupTitle": "QuestActivities"
  },
  {
    "type": "patch",
    "url": "/completions/:id",
    "title": "Update a tracked completion",
    "name": "CompletionUpdate",
    "group": "QuestActivityCompletion",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of the completion being updated</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "activity_id",
            "description": "<p>The id of the completed activity</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X PATCH \\\nhttp://localhost:3000/completions/1 \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache' \\\n-H 'Content-Type: application/json' \\\n-d '{\n    \"quest_completion\": {\n        \"activity_id\": 2\n    }\n}'",
          "type": "curl"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_completions_controller.rb",
    "groupTitle": "QuestActivityCompletion",
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "completion",
            "description": "<p>Container for the completion data</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.id",
            "description": "<p>ID of the created completion</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.person_id",
            "description": "<p>The ID of the user who completed the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.quest_id",
            "description": "<p>ID of the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.activity_id",
            "description": "<p>ID of the activity that was completed</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "completion.created_at",
            "description": "<p>The date and time the completion was created.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"completion\": {\n        \"id\": \"1\",\n        \"person_id\": \"1\",\n        \"activity_id\": \"1\",\n        \"create_time\": \"2018-05-08T23:24:48Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    }
  },
  {
    "type": "get",
    "url": "/activities/:id/completions",
    "title": "Get completions for an activity",
    "name": "GetActivityCompletions",
    "group": "QuestActivityCompletion",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "id",
            "optional": false,
            "field": "id",
            "description": "<p>Activity ID</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "https://localhost:3000/quest_activity/1/completions",
          "type": "url"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_completions_controller.rb",
    "groupTitle": "QuestActivityCompletion",
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "completions",
            "description": "<p>Container for the completion data</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.id",
            "description": "<p>ID of the created completion</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.person_id",
            "description": "<p>The ID of the user who completed the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.quest_id",
            "description": "<p>ID of the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.activity_id",
            "description": "<p>ID of the activity that was completed</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "completions.created_at",
            "description": "<p>The date and time the completion was created.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "{\n    \"completions\": [\n        {\n            \"id\": \"1\",\n            \"person_id\": \"1\",\n            \"activity_id\": \"1\",\n            \"create_time\": \"2018-05-09T17:14:07Z\"\n        },\n        {\n            \"id\": \"2\",\n            \"person_id\": \"1\",\n            \"activity_id\": \"2\",\n            \"create_time\": \"2018-05-09T17:14:13Z\"\n        }\n    ]\n}",
          "type": "Object[]"
        }
      ]
    }
  },
  {
    "type": "get",
    "url": "/completions/:id",
    "title": "Get a quest by completion id",
    "name": "GetCompletion",
    "group": "QuestActivityCompletion",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of the completion</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X GET \\\nhttp://localhost:3000/completions/1 \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "curl"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_completions_controller.rb",
    "groupTitle": "QuestActivityCompletion",
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "completion",
            "description": "<p>Container for the completion data</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.id",
            "description": "<p>ID of the created completion</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.person_id",
            "description": "<p>The ID of the user who completed the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.quest_id",
            "description": "<p>ID of the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.activity_id",
            "description": "<p>ID of the activity that was completed</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "completion.created_at",
            "description": "<p>The date and time the completion was created.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"completion\": {\n        \"id\": \"1\",\n        \"person_id\": \"1\",\n        \"activity_id\": \"1\",\n        \"create_time\": \"2018-05-08T23:24:48Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    }
  },
  {
    "type": "get",
    "url": "/quests/:id/completions",
    "title": "Get completed activities for quest for currently logged in user",
    "name": "GetCompletions",
    "group": "QuestActivityCompletion",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "id",
            "optional": false,
            "field": "id",
            "description": "<p>Quest ID</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X GET \\\nhttp://192.168.1.110:3000/quests/1/completions \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "curl"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_completions_controller.rb",
    "groupTitle": "QuestActivityCompletion",
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "completion",
            "description": "<p>Container for the completion data</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.id",
            "description": "<p>ID of the created completion</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.person_id",
            "description": "<p>The ID of the user who completed the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.quest_id",
            "description": "<p>ID of the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.activity_id",
            "description": "<p>ID of the activity that was completed</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "completion.created_at",
            "description": "<p>The date and time the completion was created.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"completion\": {\n        \"id\": \"1\",\n        \"person_id\": \"1\",\n        \"activity_id\": \"1\",\n        \"create_time\": \"2018-05-08T23:24:48Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    }
  },
  {
    "type": "get",
    "url": "/people/:id/completions",
    "title": "Get all activities a person has completed",
    "name": "GetPersonCompletions",
    "group": "QuestActivityCompletion",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "id",
            "optional": false,
            "field": "id",
            "description": "<p>Person ID</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X GET \\\nhttp://api.examplecom/people/1/completions \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "curl"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_completions_controller.rb",
    "groupTitle": "QuestActivityCompletion",
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "completion",
            "description": "<p>Container for the completion data</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.id",
            "description": "<p>ID of the created completion</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.person_id",
            "description": "<p>The ID of the user who completed the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.quest_id",
            "description": "<p>ID of the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completion.activity_id",
            "description": "<p>ID of the activity that was completed</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "completion.created_at",
            "description": "<p>The date and time the completion was created.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"completion\": {\n        \"id\": \"1\",\n        \"person_id\": \"1\",\n        \"activity_id\": \"1\",\n        \"create_time\": \"2018-05-08T23:24:48Z\"\n    }\n}",
          "type": "Object"
        }
      ]
    }
  },
  {
    "type": "post",
    "url": "/quests",
    "title": "Create a quest",
    "name": "CreateQuest",
    "group": "Quests",
    "version": "1.0.0",
    "description": "<p>Creates a quest for the product.</p>",
    "permission": [
      {
        "name": "admin"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "product",
            "description": "<p>Product name. Uses current_user if not passed.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "quest",
            "description": "<p>Quest container for form data</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "quest.event_id",
            "description": "<p>Optional event id to attach a quest to an event</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "quest.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "quest.internal_name",
            "description": "<p>Internal name for the quest</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "quest.description",
            "description": "<p>Desciption of the quest.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": true,
            "field": "quest.picture",
            "description": "<p>Image attached to the quest</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "quest.status",
            "description": "<p>Current quest status. Can be Active, Enabled, Disabled or Deleted</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": false,
            "field": "quest.starts_at",
            "description": "<p>Datetime String for when the quest starts.</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "quest.ends_at",
            "description": "<p>Datetime String for when the quest is over.</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "quest",
            "description": "<p>Quest object that was saved to the database</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.id",
            "description": "<p>ID of quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.product_id",
            "description": "<p>Product id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.event_id",
            "description": "<p>Optional event id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.description",
            "description": "<p>Description of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.picture_url",
            "description": "<p>The url for the attached picture</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.status",
            "description": "<p>The current status of the quest. Can be Active, Enabled, Disabled.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quest.starts_at",
            "description": "<p>When the quest should be active.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quest.ends_at",
            "description": "<p>Optional end time for when the quest should be disabled.</p>"
          },
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quest.activities",
            "description": "<p>The activities associated with the quest</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n   \"quest\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"event_id\": \"\",\n        \"name\": \"Don't get caught\",\n        \"internal_name\": \"national_treasure\",\n        \"description\": \"Steal the Declaration of Independence\",\n        \"picture_url\": null,\n        \"status\": \"enabled\",\n        \"starts_at\": \"1776-07-04T10:22:08Z\",\n        \"ends_at\": \"2004-11-19T10:22:08Z\",\n        \"create_time\": \"2018-04-30T23:00:20Z\",\n        \"activities\": null\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quests_controller.rb",
    "groupTitle": "Quests"
  },
  {
    "type": "get",
    "url": "/quests/:id",
    "title": "Get a single quest",
    "name": "GetQuest",
    "group": "Quests",
    "version": "1.0.0",
    "description": "<p>Returns a single quest for a product</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of the activity</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"id\" : 1\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "Quest",
            "description": "<p>Single quest returned from id</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.id",
            "description": "<p>ID of quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.product_id",
            "description": "<p>Product id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.event_id",
            "description": "<p>Optional event id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.description",
            "description": "<p>Description of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.picture_url",
            "description": "<p>The url for the attached picture</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.status",
            "description": "<p>The current status of the quest. Can be Active, Enabled, Disabled.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quest.starts_at",
            "description": "<p>When the quest should be active.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quest.ends_at",
            "description": "<p>Optional end time for when the quest should be disabled.</p>"
          },
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quest.activities",
            "description": "<p>The activities associated with the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.activities.id",
            "description": "<p>ID of the activity</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.activities.description",
            "description": "<p>The description of the activity</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.activities.hint",
            "description": "<p>Hint associated with the activity</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quest.activities.post",
            "description": "<p>Whether or not the activity requires a post to be created.</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quest.activities.image",
            "description": "<p>Whether or not the activity requires an image to be taken.</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quest.activities.audio",
            "description": "<p>Whether or not the activity requires an audio clip.</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.activities.beacon",
            "description": "<p>The beacon associated with the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.activities.step",
            "description": "<p>The step number for quest progression</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n    \"quest\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"event_id\": \"\",\n        \"name\": \"Don't get caught\",\n        \"internal_name\": \"national_treasure\",\n        \"description\": \"Steal the Declaration of Independence\",\n        \"picture_url\": null,\n        \"status\": \"enabled\",\n        \"starts_at\": \"1776-07-04T10:22:08Z\",\n        \"ends_at\": \"2004-11-19T10:22:08Z\",\n        \"create_time\": \"2018-04-30T23:00:20Z\",\n        \"activities\": null\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quests_controller.rb",
    "groupTitle": "Quests"
  },
  {
    "type": "get",
    "url": "/quests/list",
    "title": "Get a list of all quests (ADMIN ONLY)",
    "name": "GetQuestList",
    "group": "Quests",
    "version": "1.0.0",
    "description": "<p>Returns a list of all quests regardless of status.</p>",
    "permission": [
      {
        "name": "admin"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "product_id_filter",
            "description": "<p>Full match on product id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "name_filter",
            "description": "<p>Full or partial match on quest name.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "internal_name_filter",
            "description": "<p>Full or partial match on quest's internal name.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "description_filter",
            "description": "<p>Full or partial match on the quest description.</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "starts_at_filter",
            "description": "<p>Quest starts at or after timestamp. Format: &quot;2018-01-08'T'12:13:42'Z'&quot;</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "ends_at_filter",
            "description": "<p>Quest ends at or before timestamp. Format: &quot;2018-01-08'T'12:13:42'Z'&quot;</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "status_filter",
            "description": "<p>Quest status. Valid values: active enabled disabled deleted</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quests",
            "description": "<p>List of quests for product</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.id",
            "description": "<p>ID of quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.product_id",
            "description": "<p>Product id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.event_id",
            "description": "<p>Optional event id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.description",
            "description": "<p>Description of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.picture_url",
            "description": "<p>The url for the attached picture</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.status",
            "description": "<p>The current status of the quest. Can be Active, Enabled, Disabled.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quests.starts_at",
            "description": "<p>When the quest should be active.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quests.ends_at",
            "description": "<p>Optional end time for when the quest should be disabled.</p>"
          },
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quests.activities",
            "description": "<p>The activities associated with the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.activities.id",
            "description": "<p>ID of the activity</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.activities.description",
            "description": "<p>The description of the activity</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.activities.hint",
            "description": "<p>Hint associated with the activity</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quests.activities.post",
            "description": "<p>Whether or not the activity requires a post to be created.</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quests.activities.image",
            "description": "<p>Whether or not the activity requires an image to be taken.</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quests.activities.audio",
            "description": "<p>Whether or not the activity requires an audio clip.</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.activities.beacon",
            "description": "<p>The beacon associated with the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.activities.step",
            "description": "<p>The step number for quest progression</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 OK\n{\n   \"quests\":\n      [\n           {\n              \"quest_id\": 1,\n              \"product_id\": 1,\n              \"event_id\": 99,\n              \"name\": \"My New Quest\",\n              \"description\": \"Find Waldy\",\n              \"picture_url\": https://assets.example.com/hi.jpg,\n              \"status\": \"enabled\",\n              \"starts_at\": \"2031-08-18T10:22:08Z\",\n              \"ends_at\": \"2033-08-18T10:22:08Z\",\n              \"activities\": [{See Quest_Activity#show method}]\n           \n          },\n          {\n              \"quest_id\": 2,\n              \"product_id\": 1,\n              \"event_id\": 102,\n              \"name\": \"Don't get caught\",\n              \"description\": \"Steal the Declaration of Independence\",\n              \"picture_url\": https://assets.example.com/hi.jpg,\n              \"status\": \"deleted\",\n              \"starts_at\": 1776-07-04T10:22:08Z,\n              \"ends_at\": 2004-11-19T10:22:08Z\n      },\n   ]\n}",
          "type": "200"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quests_controller.rb",
    "groupTitle": "Quests"
  },
  {
    "type": "GET",
    "url": "/quests",
    "title": "Get quests for a product",
    "name": "GetQuests",
    "group": "Quests",
    "version": "1.0.0",
    "description": "<p>Gets quests that haven't been soft deleted.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "product",
            "description": "<p>Product name. Uses current_user if not passed.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n    \"product\" : \"admin\"\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quests",
            "description": "<p>List of quests for product</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.id",
            "description": "<p>ID of quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.product_id",
            "description": "<p>Product id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.event_id",
            "description": "<p>Optional event id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.description",
            "description": "<p>Description of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.picture_url",
            "description": "<p>The url for the attached picture</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.status",
            "description": "<p>The current status of the quest. Can be Active, Enabled, Disabled.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quests.starts_at",
            "description": "<p>When the quest should be active.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quests.ends_at",
            "description": "<p>Optional end time for when the quest should be disabled.</p>"
          },
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quests.activities",
            "description": "<p>The activities associated with the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.activities.id",
            "description": "<p>ID of the activity</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.activities.description",
            "description": "<p>The description of the activity</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.activities.hint",
            "description": "<p>Hint associated with the activity</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quests.activities.post",
            "description": "<p>Whether or not the activity requires a post to be created.</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quests.activities.image",
            "description": "<p>Whether or not the activity requires an image to be taken.</p>"
          },
          {
            "group": "200",
            "type": "Boolean",
            "optional": false,
            "field": "quests.activities.audio",
            "description": "<p>Whether or not the activity requires an audio clip.</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quests.activities.beacon",
            "description": "<p>The beacon associated with the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quests.activities.step",
            "description": "<p>The step number for quest progression</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 OK\n{\n   \"quests\":\n      [\n           {\n              \"quest_id\": 1,\n              \"product_id\": 1,\n              \"event_id\": 99,\n              \"name\": \"My New Quest\",\n              \"description\": \"Find Waldy\",\n              \"picture_url\": \"https://assets.example.com/hi.jpg\",\n              \"status\": \"enabled\",\n              \"starts_at\": \"2031-08-18T10:22:08Z\",\n              \"ends_at\": \"2033-08-18T10:22:08Z\",\n              \"activities\": [\n                   \"activity\": {\n                       See quest_activity#index\n               ]\n           \n          },\n          {\n              \"quest_id\": 2,\n              \"product_id\": 1,\n              \"event_id\": 102,\n              \"name\": \"Don't get caught\",\n              \"description\": \"Steal the Declaration of Independence\",\n              \"picture\": {object},\n              \"status\": \"enabled\",\n              \"starts_at\": 1776-07-04T10:22:08Z,\n              \"ends_at\": 2004-11-19T10:22:08Z\n      },\n   ]\n}",
          "type": "Object[]"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quests_controller.rb",
    "groupTitle": "Quests"
  },
  {
    "type": "delete",
    "url": "/quests/:id",
    "title": "Delete Quest",
    "name": "QuestDelete",
    "group": "Quests",
    "version": "1.0.0",
    "permission": [
      {
        "name": "admin, superadmin"
      }
    ],
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of quest to delete</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Header",
            "optional": false,
            "field": "ok",
            "description": "<p>Returns a 200 OK response</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK",
          "type": "Header"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quests_controller.rb",
    "groupTitle": "Quests"
  },
  {
    "type": "patch",
    "url": "/quest/:id",
    "title": "Update a quest",
    "name": "QuestUpdate",
    "group": "Quests",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>ID of the quest to update</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "product",
            "description": "<p>Product name. Uses current_user if not passed.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "quest",
            "description": "<p>Quest container for form data</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "quest.event_id",
            "description": "<p>Optional event id to attach a quest to an event</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "quest.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "quest.internal_name",
            "description": "<p>Internal name for the quest</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "quest.description",
            "description": "<p>Desciption of the quest.</p>"
          },
          {
            "group": "Parameter",
            "type": "Object",
            "optional": true,
            "field": "quest.picture",
            "description": "<p>Image attached to the quest</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "quest.status",
            "description": "<p>Current quest status. Can be Active, Enabled, Disabled or Deleted</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "quest.starts_at",
            "description": "<p>Datetime String for when the quest starts.</p>"
          },
          {
            "group": "Parameter",
            "type": "Datetime",
            "optional": true,
            "field": "quest.ends_at",
            "description": "<p>Datetime String for when the quest is over.</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "quest",
            "description": "<p>Quest object that was saved to the database</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.id",
            "description": "<p>ID of quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.product_id",
            "description": "<p>Product id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "quest.event_id",
            "description": "<p>Optional event id the quest is attached to</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.name",
            "description": "<p>Name of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.description",
            "description": "<p>Description of the quest</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.picture_url",
            "description": "<p>The url for the attached picture</p>"
          },
          {
            "group": "200",
            "type": "String",
            "optional": false,
            "field": "quest.status",
            "description": "<p>The current status of the quest. Can be Active, Enabled, Disabled.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quest.starts_at",
            "description": "<p>When the quest should be active.</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "quest.ends_at",
            "description": "<p>Optional end time for when the quest should be disabled.</p>"
          },
          {
            "group": "200",
            "type": "Object[]",
            "optional": false,
            "field": "quest.activities",
            "description": "<p>The activities associated with the quest</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n   \"quest\": {\n        \"id\": \"1\",\n        \"product_id\": \"1\",\n        \"event_id\": \"\",\n        \"name\": \"Don't get caught\",\n        \"internal_name\": \"national_treasure\",\n        \"description\": \"Steal the Declaration of Independence\",\n        \"picture_url\": null,\n        \"status\": \"enabled\",\n        \"starts_at\": \"1776-07-04T10:22:08Z\",\n        \"ends_at\": \"2004-11-19T10:22:08Z\",\n        \"create_time\": \"2018-04-30T23:00:20Z\",\n        \"activities\": null\n    }\n}",
          "type": "Object"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quests_controller.rb",
    "groupTitle": "Quests"
  },
  {
    "type": "delete",
    "url": "/relationships/:id",
    "title": "Unfriend a person.",
    "name": "DeleteRelationship",
    "group": "Relationship",
    "description": "<p>This is used to unfriend a person.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "id",
            "description": "<p>id of the underlying relationship</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/relationships_controller.rb",
    "groupTitle": "Relationship"
  },
  {
    "type": "post",
    "url": "/relationships",
    "title": "Send a friend request to a person.",
    "name": "CreateRelationship",
    "group": "Relationships",
    "description": "<p>This is used to send a friend request to a person. If there is a block between the people, an error will be returned.</p> <p>If the person sending the request already has a pending request (or friendship) from the requested_to_id, then no additional records will be created. The original relationship will be changed to friended (if not already) and returned.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "relationship",
            "description": "<p>Relationship object.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "relationship.requested_to_id",
            "description": "<p>Person for whom the request is intended</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"relationship\": {\n  \"id\" : 123, #id of the relationship\n  \"requested_by\" : { ...public json of the person requesting },\n  \"requested_to\" : { ...public json of the person requested }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"You already spammed that person, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/relationships_controller.rb",
    "groupTitle": "Relationships"
  },
  {
    "type": "get",
    "url": "/relationships/:id",
    "title": "Get a single relationship.",
    "name": "GetRelationship",
    "group": "Relationships",
    "description": "<p>This gets a single relationship for a relationship id. Only available to a participating user.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"relationship\": {\n    \"id\": \"5016\",\n    \"status\": \"requested\",\n    \"created_time\": \"2018-01-08'T'12:13:42'Z'\",\n    \"update_time\": \"2018-01-08'T'12:13:42'Z'\",\n    \"requested_by\": { ... public person json },\n    \"requested_to\": { ... public person json }\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/relationships_controller.rb",
    "groupTitle": "Relationships"
  },
  {
    "type": "get",
    "url": "/relationships",
    "title": "Get current relationships of a person.",
    "name": "GetRelationships",
    "group": "Relationships",
    "description": "<p>This is used to get a list of someone's friends. If the person supplied is the logged in user, 'requested' status is included for requests TO the current user. Otherwise, only 'friended' status is included.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": true,
            "field": "person_id",
            "description": "<p>Person whose friends to get</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "  HTTP/1.1 200 Ok\n\"relationships\" {\n  [ ... relationship json ...],\n  ....\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/relationships_controller.rb",
    "groupTitle": "Relationships"
  },
  {
    "type": "patch",
    "url": "/relationships",
    "title": "Update a relationship.",
    "name": "UpdateRelationship",
    "group": "Relationships",
    "description": "<p>This is used to accept, deny or unfriend a relationship (friend request).</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "relationship",
            "description": "<p>Relationship object.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "relationship.status",
            "description": "<p>New status. Valid values are &quot;friended&quot;, &quot;denied&quot; or &quot;withdrawn&quot;. However each one is only valid in the state and/or from the person that you would expect (e.g. the relationship requester cannot update with &quot;friended&quot;).</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"relationship\": {\n  \"id\" : 123, #id of the relationship\n  \"status\": \"friended\"\n  \"create_time\": \"\"2018-01-08'T'12:13:42'Z'\"\"\n  \"updated_time\": \"\"2018-01-08'T'12:13:42'Z'\"\"\n  \"requested_by\" : { ...public json of the person requesting },\n  \"requested_to\" : { ...public json of the person requested }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"You can't friend your own request, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/relationships_controller.rb",
    "groupTitle": "Relationships"
  },
  {
    "type": "post",
    "url": "/rooms",
    "title": "Create a private room.",
    "name": "CreateRoom",
    "group": "Rooms",
    "description": "<p>The creates a private room and makes it active.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "room",
            "description": "<p>The room object container for the room parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "room.name",
            "description": "<p>The name of the room. Must be between 3 and 26 characters, inclusive.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "room.description",
            "description": "<p>The description of the room.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "room.picture",
            "description": "<p>NOT YET IMPLEMENTED</p>"
          },
          {
            "group": "Parameter",
            "type": "Array",
            "optional": true,
            "field": "room.member_ids",
            "description": "<p>Ids of persons to add as members.  Users who are blocked by or who are blocking the current user will be silently excluded. You do not need to include the current user, who will be made a member automatically.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"room\":\n  {\n    \"id\": \"5016\",\n    \"name\": \"Motley People Only\",\n    \"description\": \"Room description\",\n    \"owned\": \"true\", # is current user the owner of room?\n    \"picture_url\": \"http://host.name/path\",\n    \"members\": [\n      {\n        ....person json...\n      },....\n    ]\n\n  }",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"That name is too short, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/rooms_controller.rb",
    "groupTitle": "Rooms"
  },
  {
    "type": "post",
    "url": "/room/id/room_memberships",
    "title": "Add a room member.",
    "name": "CreateRoomMembership",
    "group": "Rooms",
    "description": "<p>This adds a person to a private room. On success (person added), just returns 200.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "person",
            "description": "<p>The person object.</p>"
          },
          {
            "group": "Parameter",
            "type": "Integer",
            "optional": false,
            "field": "person.id",
            "description": "<p>The id of the person.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 or 422 Unprocessable - Room not active (404), current user not room owner (404), person is unwanted or illigitimate (422), etc.",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/room_memberships_controller.rb",
    "groupTitle": "Rooms"
  },
  {
    "type": "delete",
    "url": "/rooms/id",
    "title": "Delete a private room.",
    "name": "DeleteRoom",
    "group": "Rooms",
    "description": "<p>The deletes a private room. If it has no messages, it deletes it completely. Otherwise, it just changes the status to deleted.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 401, 404",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/rooms_controller.rb",
    "groupTitle": "Rooms"
  },
  {
    "type": "get",
    "url": "/rooms",
    "title": "Get a list of rooms.",
    "name": "GetRooms",
    "group": "Rooms",
    "description": "<p>This gets a list of active rooms (public or private, as specified by the &quot;private&quot; parameter).</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "private",
            "description": "<p>Which type of room you want. With true you will get just active private rooms of which the current user is a member. With false (the default), you will get just all active public rooms.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"rooms\": [\n  {\n    ....see room json under create above ....\n  },...\n]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/rooms_controller.rb",
    "groupTitle": "Rooms"
  },
  {
    "type": "patch",
    "url": "/rooms/id",
    "title": "Update a private room (name).",
    "name": "UpdateRoom",
    "group": "Rooms",
    "description": "<p>The updates a private room. Only the name can by updated, and only by the owner.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Object",
            "optional": false,
            "field": "room",
            "description": "<p>The room object container for the room parameters.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "room.name",
            "description": "<p>The name of the room. Must be between 3 and 26 characters, inclusive.</p>"
          },
          {
            "group": "Parameter",
            "type": "Attachment",
            "optional": true,
            "field": "room.picture",
            "description": "<p>NOT YET IMPLEMENTED</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"room\":\n  {\n    ...see room json for create room...\n  }",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 422\n\"errors\" :\n  { \"That name is too short, blah blah blah\" }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/rooms_controller.rb",
    "groupTitle": "Rooms"
  },
  {
    "type": "post",
    "url": "/session",
    "title": "Log someone in.",
    "name": "CreateSession",
    "group": "Sessions",
    "description": "<p>This is used to log someone in.</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "product",
            "description": "<p>Internal name of product logging into.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "email_or_username",
            "description": "<p>The person's email address or username. Required unless using Facebook ID.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "facebook_auth_token",
            "description": "<p>The facebook auth token. Required unless using username/password.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "password",
            "description": "<p>The person's password. Required unless using facebook_auth_token</p>"
          },
          {
            "group": "Parameter",
            "type": "Boolean",
            "optional": true,
            "field": "keep",
            "description": "<p>NOT YET SUPPORTED True if you want to keep them signed in, otherwise this will be a non-persistent session.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"person\": {\n  \"email\": \"addr@example.com\",\n  ...see person get for the rest of the fields...\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/session_controller.rb",
    "groupTitle": "Sessions"
  },
  {
    "type": "delete",
    "url": "/session",
    "title": "Log someone out.",
    "name": "DestroySession",
    "group": "Sessions",
    "description": "<p>This is used to log someone out.</p>",
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/session_controller.rb",
    "groupTitle": "Sessions"
  },
  {
    "type": "get",
    "url": "/session",
    "title": "Check a session.",
    "name": "GetSession",
    "group": "Sessions",
    "description": "<p>This is used to see if your current session is valid. We return the currently logged-in person if the session is still good and a 404 otherwise.</p>",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 Ok\n\"person\": {\n  \"id\": \"5016\",\n  \"email\": \"addr@example.com\",\n  \"username\": \"Pancakes.McGee\",\n  \"name\": \"Pancakes McGee\",\n  \"picture_url\": \"http://host.name/path\",\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/session_controller.rb",
    "groupTitle": "Sessions"
  },
  {
    "type": "get",
    "url": "/quests/:id/completions/list",
    "title": "Get a quest by completion id",
    "name": "apiName",
    "group": "group",
    "version": "1.0.0",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "page",
            "description": "<p>The page number to get. Default is 1.</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "per_page",
            "description": "<p>The pagination division. Default is 25.</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "person_id_filter",
            "description": "<p>Full match on person id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "person_filter",
            "description": "<p>Full match name or email of person.</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "quest_id_filter",
            "description": "<p>Full match on quest id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "quest_filter",
            "description": "<p>Full match name of quest.</p>"
          },
          {
            "group": "Parameter",
            "type": "Number",
            "optional": true,
            "field": "activity_id_filter",
            "description": "<p>Full match on activity id.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": true,
            "field": "activity_filter",
            "description": "<p>Full match name of activity.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "curl -X GET \\\n'http://localhost:3000/completions/list?person__id_filter=1' \\\n-H 'Accept: application/vnd.api.v2+json' \\\n-H 'Cache-Control: no-cache'",
          "type": "curl"
        }
      ]
    },
    "filename": "app/controllers/api/v1/quest_completions_controller.rb",
    "groupTitle": "group",
    "success": {
      "fields": {
        "200": [
          {
            "group": "200",
            "type": "Object",
            "optional": false,
            "field": "completions",
            "description": "<p>Container for the completion data</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.id",
            "description": "<p>ID of the created completion</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.person_id",
            "description": "<p>The ID of the user who completed the activity</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.quest_id",
            "description": "<p>ID of the quest</p>"
          },
          {
            "group": "200",
            "type": "Number",
            "optional": false,
            "field": "completions.activity_id",
            "description": "<p>ID of the activity that was completed</p>"
          },
          {
            "group": "200",
            "type": "DateTime",
            "optional": false,
            "field": "completions.created_at",
            "description": "<p>The date and time the completion was created.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "{\n    \"completions\": [\n        {\n            \"id\": \"1\",\n            \"person_id\": \"1\",\n            \"activity_id\": \"1\",\n            \"create_time\": \"2018-05-09T17:14:07Z\"\n        },\n        {\n            \"id\": \"2\",\n            \"person_id\": \"1\",\n            \"activity_id\": \"2\",\n            \"create_time\": \"2018-05-09T17:14:13Z\"\n        }\n    ]\n}",
          "type": "Object[]"
        }
      ]
    }
  }
] });
