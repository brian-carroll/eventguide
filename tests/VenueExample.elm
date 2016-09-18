module VenueExample exposing (json)

json : String
json = """  
      {  
        "name":"Heaven",
        "type":"venue",
        "id":"KovZ9177Aa7",
        "test":false,
        "url":"http://ticketmaster.co.uk/venue/254189",
        "locale":"en-us",
        "postalCode":"WC2N 6NG",
        "timezone":"Europe/London",
        "city":{  
          "name":"London"
        },
        "country":{  
          "name":"Great Britain",
          "countryCode":"GB"
        },
        "address":{  
          "line1":"Under The Arches",
          "line2":"Villiers Street"
        },
        "location":{  
          "longitude":"-0.12413400",
          "latitude":"51.50809700"
        },
        "markets":[  
          {  
            "id":"201"
          },
          {  
            "id":"202"
          }
        ],
        "dmas":[  
          {  
            "id":601
          },
          {  
            "id":602
          }
        ],
        "_links":{  
          "self":{  
            "href":"/discovery/v2/venues/KovZ9177Aa7?locale=en-us"
          }
        }
      }
      """
