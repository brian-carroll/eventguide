module EventExample exposing (json)
-- import Date
-- import TicketMaster exposing (EventStatus(Rescheduled))

json : String
json = """
{  
  "name":"Sundara Karma",
  "type":"event",
  "id":"G5vHZfklPcAEZ",
  "test":false,
  "url":"http://ticketmaster.co.uk/event/1F00506AE5B459C0",
  "locale":"en-us",
  "images":[  
    {  
      "ratio":"4_3",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_CUSTOM.jpg",
      "width":305,
      "height":225,
      "fallback":true
    },
    {  
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_EVENT_DETAIL_PAGE_16_9.jpg",
      "width":205,
      "height":115,
      "fallback":true
    },
    {  
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RETINA_PORTRAIT_16_9.jpg",
      "width":640,
      "height":360,
      "fallback":true
    },
    {  
      "ratio":"3_2",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_TABLET_LANDSCAPE_3_2.jpg",
      "width":1024,
      "height":683,
      "fallback":true
    },
    {  
      "ratio":"3_2",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RETINA_PORTRAIT_3_2.jpg",
      "width":640,
      "height":427,
      "fallback":true
    },
    {  
      "ratio":"3_2",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_ARTIST_PAGE_3_2.jpg",
      "width":305,
      "height":203,
      "fallback":true
    },
    {  
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RECOMENDATION_16_9.jpg",
      "width":100,
      "height":56,
      "fallback":true
    },
    {  
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_TABLET_LANDSCAPE_16_9.jpg",
      "width":1024,
      "height":576,
      "fallback":true
    },
    {  
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_TABLET_LANDSCAPE_LARGE_16_9.jpg",
      "width":2048,
      "height":1152,
      "fallback":true
    },
    {  
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RETINA_LANDSCAPE_16_9.jpg",
      "width":1136,
      "height":639,
      "fallback":true
    }
  ],
  "sales":{  
    "public":{  
      "startDateTime":"2016-03-16T09:00:00Z",
      "startTBD":false,
      "endDateTime":"2016-09-16T17:45:00Z"
    },
    "presales":[  
      {  
        "startDateTime":"2016-03-15T09:00:00Z",
        "endDateTime":"2016-03-16T08:00:00Z",
        "name":"Live Nation Presale"
      },
      {  
        "startDateTime":"2016-03-14T09:00:00Z",
        "endDateTime":"2016-03-16T08:00:00Z",
        "name":"O2 Presale"
      }
    ]
  },
  "dates":{  
    "start":{  
      "localDate":"2016-09-16",
      "localTime":"18:45:00",
      "dateTime":"2016-09-16T17:45:00Z",
      "dateTBD":false,
      "dateTBA":false,
      "timeTBA":false,
      "noSpecificTime":false
    },
    "timezone":"Europe/London",
    "status":{  
      "code":"rescheduled"
    }
  },
  "classifications":[  
    {  
      "primary":true,
      "segment":{  
        "id":"KZFzniwnSyZfZ7v7nJ",
        "name":"Music"
      },
      "genre":{  
        "id":"KnvZfZ7vAeA",
        "name":"Rock"
      },
      "subGenre":{  
        "id":"KZazBEonSMnZfZ7v6F1",
        "name":"Pop"
      }
    }
  ],
  "promoter":{  
    "id":"4110",
    "name":"LIVE NATION (MUSIC) LTD",
    "description":"LIVE NATION (MUSIC) LTD / NTL / GBR"
  },
  "info":"Doors 18:45, starts 19:25",
  "pleaseNote":"Ages 14+ only. Under 16s must be accompanied by an adult. Photo ID Required. Plus support Inheaven.",
  "_links":{  
    "self":{  
      "href":"/discovery/v2/events/G5vHZfklPcAEZ?locale=en-us"
    },
    "attractions":[  
      {  
        "href":"/discovery/v2/attractions/K8vZ9173RD7?locale=en-us"
      }
    ],
    "venues":[  
      {  
        "href":"/discovery/v2/venues/KovZ9177Aa7?locale=en-us"
      }
    ]
  },
  "_embedded":{  
    "venues":[  
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
    ],
    "attractions":[  
      {  
        "name":"Sundara Karma",
        "type":"attraction",
        "id":"K8vZ9173RD7",
        "test":false,
        "url":"http://ticketmaster.co.uk/artist/2027720",
        "locale":"en-us",
        "images":[  
          {  
            "ratio":"4_3",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_CUSTOM.jpg",
            "width":305,
            "height":225,
            "fallback":true
          },
          {  
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_EVENT_DETAIL_PAGE_16_9.jpg",
            "width":205,
            "height":115,
            "fallback":true
          },
          {  
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RETINA_PORTRAIT_16_9.jpg",
            "width":640,
            "height":360,
            "fallback":true
          },
          {  
            "ratio":"3_2",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_TABLET_LANDSCAPE_3_2.jpg",
            "width":1024,
            "height":683,
            "fallback":true
          },
          {  
            "ratio":"3_2",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RETINA_PORTRAIT_3_2.jpg",
            "width":640,
            "height":427,
            "fallback":true
          },
          {  
            "ratio":"3_2",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_ARTIST_PAGE_3_2.jpg",
            "width":305,
            "height":203,
            "fallback":true
          },
          {  
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RECOMENDATION_16_9.jpg",
            "width":100,
            "height":56,
            "fallback":true
          },
          {  
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_TABLET_LANDSCAPE_16_9.jpg",
            "width":1024,
            "height":576,
            "fallback":true
          },
          {  
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_TABLET_LANDSCAPE_LARGE_16_9.jpg",
            "width":2048,
            "height":1152,
            "fallback":true
          },
          {  
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/c/fbc/b293c0ad-c904-4215-bc59-8d7f2414dfbc_106141_RETINA_LANDSCAPE_16_9.jpg",
            "width":1136,
            "height":639,
            "fallback":true
          }
        ],
        "classifications":[  
          {  
            "primary":true,
            "segment":{  
              "id":"KZFzniwnSyZfZ7v7nJ",
              "name":"Music"
            },
            "genre":{  
              "id":"KnvZfZ7vAeA",
              "name":"Rock"
            },
            "subGenre":{  
              "id":"KZazBEonSMnZfZ7v6F1",
              "name":"Pop"
            }
          }
        ],
        "_links":{  
          "self":{  
            "href":"/discovery/v2/attractions/K8vZ9173RD7?locale=en-us"
          }
        }
      }
    ]
  }
}
"""

-- elmValue =
--   Ok  { name = "Sundara Karma"
--       , type' = "event"
--       , id = "G5vHZfklPcAEZ"
--       , test = False
--       , url = "http://ticketmaster.co.uk/event/1F00506AE5B459C0"
--       , locale = "en-us"
--       , sales = 
--         { public = 
--           { startDateTime = Date.fromString "Wed Mar 16 2016 09:00:00 GMT+0000 (GMT)"
--           , startTBD = False
--           , endDateTime = Date.fromString "Fri Sep 16 2016 18:45:00 GMT+0100 (BST)" 
--           }
--         , presales = 
--           [
--             { startDateTime = Date.fromString "Tue Mar 15 2016 09:00:00 GMT+0000 (GMT)"
--             , endDateTime = Date.fromString "Wed Mar 16 2016 08:00:00 GMT+0000 (GMT)"
--             , name = "Live Nation Presale" 
--             }
--           , { startDateTime = Date.fromString "Mon Mar 14 2016 09:00:00 GMT+0000 (GMT)>"
--             , endDateTime = Date.fromString "Wed Mar 16 2016 08:00:00 GMT+0000 (GMT)"
--             , name = "O2 Presale" 
--             }
--           ]
--         }
--         , dates = 
--         { start = 
--           { localDate = "2016-09-16"
--           , localTime = "18:45:00"
--           , dateTime = Date.fromString "Fri Sep 16 2016 18:45:00 GMT+0100 (BST)"
--           , dateTBD = False
--           , dateTBA = False
--           , timeTBA = False
--           , noSpecificTime = False 
--           }
--         , timezone = "Europe/London"
--         , status = TicketMaster.EventStatus.Rescheduled 
--         }
--       , classifications = 
--         [
--           { primary = True
--           , segment = 
--             { id = "KZFzniwnSyZfZ7v7nJ"
--             , name = "Music" 
--             }
--           , genre = 
--             { id = "KnvZfZ7vAeA"
--             , name = "Rock" 
--             }
--           , subGenre = 
--             { id = "KZazBEonSMnZfZ7v6F1"
--             , name = "Pop" 
--             } 
--           }
--         ]
--       , promoter = Just 
--         { id = "4110"
--         , name = "LIVE NATION (MUSIC) LTD"
--         , description = "LIVE NATION (MUSIC) LTD / NTL / GBR" 
--         }
--       , info = Just "Doors 18:45, starts 19:25"
--       , pleaseNote = Just "Ages 14+ only. Under 16s must be accompanied by an adult. Photo ID Required. Plus support Inheaven." 
--   }
