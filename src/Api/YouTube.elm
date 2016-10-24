module Api.YouTube exposing (..)

{-| Auto-generated using http://noredink.github.io/json-to-elm/
-}

-- import Json.Encode
import Json.Decode exposing (Decoder, string, list, int, object1, fail, andThen, (:=))
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional)

type alias Search =
    { kind : String
    , etag : String
    , nextPageToken : String
    , regionCode : String
    , pageInfo : SearchPageInfo
    , items : List SearchResult
    }

type alias SearchPageInfo =
    { totalResults : Int
    , resultsPerPage : Int
    }

type alias SearchResult =
    { kind : String
    , etag : String
    , id : SearchResultId
    , snippet : SearchResultSnippet
    }

type SearchResultId
    = Channel String
    | Video String
    | Playlist String

type alias SearchResultSnippetThumbnail =
    { url : String
    }

type alias SearchResultSnippetThumbnails =
    { default : SearchResultSnippetThumbnail
    , medium : SearchResultSnippetThumbnail
    , high : SearchResultSnippetThumbnail
    }

type alias SearchResultSnippet =
    { publishedAt : String
    , channelId : String
    , title : String
    , description : String
    , thumbnails : SearchResultSnippetThumbnails
    , channelTitle : String
    , liveBroadcastContent : String
    }


decodeSearch : Decoder Search
decodeSearch =
    decode Search
        |> required "kind" (string)
        |> required "etag" (string)
        |> required "nextPageToken" (string)
        |> required "regionCode" (string)
        |> required "pageInfo" (decodeSearchPageInfo)
        |> required "items" (list decodeSearchResult)

decodeSearchPageInfo : Decoder SearchPageInfo
decodeSearchPageInfo =
    decode SearchPageInfo
        |> required "totalResults" (int)
        |> required "resultsPerPage" (int)

-- encodeSearch : Search -> Json.Encode.Value
-- encodeSearch record =
--     Json.Encode.object
--         [ ("kind",  Json.Encode.string <| record.kind)
--         , ("etag",  Json.Encode.string <| record.etag)
--         , ("nextPageToken",  Json.Encode.string <| record.nextPageToken)
--         , ("regionCode",  Json.Encode.string <| record.regionCode)
--         , ("pageInfo",  encodeSearchPageInfo <| record.pageInfo)
--         , ("items",  Json.Encode.list <| List.map encodeSearchResult <| record.items)
--         ]

-- encodeSearchPageInfo : SearchPageInfo -> Json.Encode.Value
-- encodeSearchPageInfo record =
--     Json.Encode.object
--         [ ("totalResults",  Json.Encode.int <| record.totalResults)
--         , ("resultsPerPage",  Json.Encode.int <| record.resultsPerPage)
--         ]


decodeSearchResult : Decoder SearchResult
decodeSearchResult =
    decode SearchResult
        |> required "kind" (string)
        |> required "etag" (string)
        |> required "id" (decodeSearchResultId)
        |> required "snippet" (decodeSearchResultSnippet)

decodeSearchResultId : Decoder SearchResultId
decodeSearchResultId =
    ("kind" := string) `andThen` idKind

idKind : String -> Decoder SearchResultId
idKind kind =
    case kind of
        "youtube#channel" ->
            object1 Channel ("channelId" := string)
        "youtube#video" ->
            object1 Video ("videoId" := string)
        "youtube#playlist" ->
            object1 Playlist ("playlistId" := string)
        _ ->
            fail "Unknown kind of YouTube object"

decodeSearchResultSnippetThumbnail : Decoder SearchResultSnippetThumbnail
decodeSearchResultSnippetThumbnail =
    decode SearchResultSnippetThumbnail
        |> required "url" (string)

decodeSearchResultSnippetThumbnails : Decoder SearchResultSnippetThumbnails
decodeSearchResultSnippetThumbnails =
    decode SearchResultSnippetThumbnails
        |> required "default" (decodeSearchResultSnippetThumbnail)
        |> required "medium" (decodeSearchResultSnippetThumbnail)
        |> required "high" (decodeSearchResultSnippetThumbnail)

decodeSearchResultSnippet : Decoder SearchResultSnippet
decodeSearchResultSnippet =
    decode SearchResultSnippet
        |> required "publishedAt" (string)
        |> required "channelId" (string)
        |> required "title" (string)
        |> required "description" (string)
        |> required "thumbnails" (decodeSearchResultSnippetThumbnails)
        |> required "channelTitle" (string)
        |> required "liveBroadcastContent" (string)

-- encodeSearchResult : SearchResult -> Json.Encode.Value
-- encodeSearchResult record =
--     Json.Encode.object
--         [ ("kind",  Json.Encode.string <| record.kind)
--         , ("etag",  Json.Encode.string <| record.etag)
--         , ("id",  encodeSearchResultId <| record.id)
--         , ("snippet",  encodeSearchResultSnippet <| record.snippet)
--         ]

-- encodeSearchResultId : SearchResultId -> Json.Encode.Value
-- encodeSearchResultId record =
--     Json.Encode.object
--         [ ("kind",  Json.Encode.string <| record.kind)
--         , ("channelId",  Json.Encode.string <| record.channelId)
--         ]

-- encodeSearchResultSnippetThumbnailsDefault : SearchResultSnippetThumbnailsDefault -> Json.Encode.Value
-- encodeSearchResultSnippetThumbnailsDefault record =
--     Json.Encode.object
--         [ ("url",  Json.Encode.string <| record.url)
--         ]

-- encodeSearchResultSnippetThumbnailsMedium : SearchResultSnippetThumbnailsMedium -> Json.Encode.Value
-- encodeSearchResultSnippetThumbnailsMedium record =
--     Json.Encode.object
--         [ ("url",  Json.Encode.string <| record.url)
--         ]

-- encodeSearchResultSnippetThumbnailsHigh : SearchResultSnippetThumbnailsHigh -> Json.Encode.Value
-- encodeSearchResultSnippetThumbnailsHigh record =
--     Json.Encode.object
--         [ ("url",  Json.Encode.string <| record.url)
--         ]

-- encodeSearchResultSnippetThumbnails : SearchResultSnippetThumbnails -> Json.Encode.Value
-- encodeSearchResultSnippetThumbnails record =
--     Json.Encode.object
--         [ ("default",  encodeSearchResultSnippetThumbnailsDefault <| record.default)
--         , ("medium",  encodeSearchResultSnippetThumbnailsMedium <| record.medium)
--         , ("high",  encodeSearchResultSnippetThumbnailsHigh <| record.high)
--         ]

-- encodeSearchResultSnippet : SearchResultSnippet -> Json.Encode.Value
-- encodeSearchResultSnippet record =
--     Json.Encode.object
--         [ ("publishedAt",  Json.Encode.string <| record.publishedAt)
--         , ("channelId",  Json.Encode.string <| record.channelId)
--         , ("title",  Json.Encode.string <| record.title)
--         , ("description",  Json.Encode.string <| record.description)
--         , ("thumbnails",  encodeSearchResultSnippetThumbnails <| record.thumbnails)
--         , ("channelTitle",  Json.Encode.string <| record.channelTitle)
--         , ("liveBroadcastContent",  Json.Encode.string <| record.liveBroadcastContent)
--         ]
