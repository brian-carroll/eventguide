module Data.ProblemEvent exposing (json)

json : String
json = """
{
  "name":"Deap Vally - 'femejism' Album",
  "type":"event",
  "id":"G5vHZfCS90B73",
  "test":false,
  "url":"http://ticketmaster.co.uk/event/1F0050ECD793A112",
  "locale":"en-us",
  "images":[
    {
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_TABLET_LANDSCAPE_16_9.jpg",
      "width":1024,
      "height":576,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_EVENT_DETAIL_PAGE_16_9.jpg",
      "width":205,
      "height":115,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RETINA_PORTRAIT_16_9.jpg",
      "width":640,
      "height":360,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RECOMENDATION_16_9.jpg",
      "width":100,
      "height":56,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"3_2",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_ARTIST_PAGE_3_2.jpg",
      "width":305,
      "height":203,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"3_2",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RETINA_PORTRAIT_3_2.jpg",
      "width":640,
      "height":427,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"3_2",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_TABLET_LANDSCAPE_3_2.jpg",
      "width":1024,
      "height":683,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"4_3",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_CUSTOM.jpg",
      "width":305,
      "height":225,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_TABLET_LANDSCAPE_LARGE_16_9.jpg",
      "width":2048,
      "height":1152,
      "fallback":false,
      "attribution":"CC BY 2.0"
    },
    {
      "ratio":"16_9",
      "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RETINA_LANDSCAPE_16_9.jpg",
      "width":1136,
      "height":639,
      "fallback":false,
      "attribution":"CC BY 2.0"
    }
  ],
  "sales":{
    "public":{
      "startDateTime":"2016-07-13T08:00:00Z",
      "startTBD":false,
      "endDateTime":"2016-09-19T22:59:00Z"
    }
  },
  "dates":{
    "start":{
      "localDate":"2016-09-19",
      "localTime":"23:59:00",
      "dateTime":"2016-09-19T22:59:00Z",
      "dateTBD":false,
      "dateTBA":false,
      "timeTBA":false,
      "noSpecificTime":false
    },
    "timezone":"Europe/London",
    "status":{
      "code":"onsale"
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
        "id":"KZazBEonSMnZfZ7v6dt",
        "name":"Alternative Rock"
      }
    }
  ],
  "promoter":{
    "id":"3675",
    "name":"TOWNSEND MUSIC LTD",
    "description":"TOWNSEND MUSIC LTD / NTL / GBR"
  },
  "pleaseNote":"Pre-order Deap Vally's amazing new album 'Femejism' now on standard CD or Vinyl LP. £Our favourite Californian rockers return sounding more fiery than ever£ - NME \"What a brilliant raging anthem!\" - Annie Mac, BBC Radio 1",
  "_links":{
    "self":{
      "href":"/discovery/v2/events/G5vHZfCS90B73?locale=en-us"
    },
    "attractions":[
      {
        "href":"/discovery/v2/attractions/K8vZ9178lF0?locale=en-us"
      }
    ],
    "venues":[
      {
        "href":"/discovery/v2/venues/KovZpZAnF77A?locale=en-us"
      }
    ]
  },
  "_embedded":{
    "venues":[
      {
        "name":"Ticketmaster",
        "type":"venue",
        "id":"KovZpZAnF77A",
        "test":false,
        "url":"http://ticketmaster.co.uk/venue/254520",
        "locale":"en-us",
        "postalCode":"N1 9HF",
        "timezone":"Europe/London",
        "city":{
          "name":"London"
        },
        "country":{
          "name":"Great Britain",
          "countryCode":"GB"
        },
        "address":{
          "line1":"Pentonville Road"
        },
        "location":{
          "longitude":"-0.13104000",
          "latitude":"51.51017600"
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
            "href":"/discovery/v2/venues/KovZpZAnF77A?locale=en-us"
          }
        }
      }
    ],
    "attractions":[
      {
        "name":"Deap Vally",
        "type":"attraction",
        "id":"K8vZ9178lF0",
        "test":false,
        "url":"http://ticketmaster.co.uk/artist/1816052",
        "locale":"en-us",
        "images":[
          {
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_TABLET_LANDSCAPE_16_9.jpg",
            "width":1024,
            "height":576,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RETINA_PORTRAIT_16_9.jpg",
            "width":640,
            "height":360,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RECOMENDATION_16_9.jpg",
            "width":100,
            "height":56,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"4_3",
            "url":"https://s1.ticketm.net/dbimages/179092a.jpg",
            "width":305,
            "height":225,
            "fallback":false
          },
          {
            "ratio":"3_2",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_ARTIST_PAGE_3_2.jpg",
            "width":305,
            "height":203,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"3_2",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RETINA_PORTRAIT_3_2.jpg",
            "width":640,
            "height":427,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"3_2",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_TABLET_LANDSCAPE_3_2.jpg",
            "width":1024,
            "height":683,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"16_9",
            "url":"https://s1.ticketm.net/dbimages/179093a.jpg",
            "width":205,
            "height":115,
            "fallback":false
          },
          {
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_TABLET_LANDSCAPE_LARGE_16_9.jpg",
            "width":2048,
            "height":1152,
            "fallback":false,
            "attribution":"CC BY 2.0"
          },
          {
            "ratio":"16_9",
            "url":"http://s1.ticketm.net/dam/a/abc/f97ca1d3-7c3c-4b0d-be59-f93998d4cabc_161291_RETINA_LANDSCAPE_16_9.jpg",
            "width":1136,
            "height":639,
            "fallback":false,
            "attribution":"CC BY 2.0"
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
              "id":"KZazBEonSMnZfZ7v6dt",
              "name":"Alternative Rock"
            }
          }
        ],
        "_links":{
          "self":{
            "href":"/discovery/v2/attractions/K8vZ9178lF0?locale=en-us"
          }
        }
      }
    ]
  }
}
"""