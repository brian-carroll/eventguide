Styling
- [ ] Make nicer cards for each event. Look at other similar sites.
- [ ] Put YouTube content in a full-screen modal & load on-demand
- [ ] State indicators (Loading spinners, Video not available)
- [ ] Pricing

User Input Form
- [ ] Dates
- [ ] Location
- [ ] Genre selection

Refactoring
- [x] Create generic Event & Video types - a record of everything the view needs.
- [x] Move all API-specific data manipulation into TicketMaster and YouTube modules
- [ ] Should I co-locate styles and views?
    - Does this run in to Elm being against components?
    - No, according to Richard Feldman on [elm-discuss](https://groups.google.com/d/msg/elm-discuss/_cfOu88oCx4/LBqcPlCCCAAJ):
        - "If the files feel too big, split them into separate files and import them. That's not a big deal. What is a big deal, and a super common beginner mistake, is to split out separate state ownership when you don't need to yet."
    - Styles are clearly part of the view
    - In Redux people do one central piece of state (good for Elm), then put views in a folder hierarchy, sometimes with css beside JSX
