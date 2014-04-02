###
Application State Data Service
Provides shared global application state data
usage:

mainApp = angular.module("MainApp", [... 'appDataSrvc'])


mainApp.controller 'MyCtlr', ['$scope', ...,'AppData',
    ($scope,...,AppData) ->

    $scope.appData = AppData.getData()
    AppData.setData
        loggedIn: true


###


angular.module("appDataSrvc", ['appConfigSrvc', "appUtilSrvc"]).factory "AppData",
  ['Configuration', 'Itemizer', (Configuration, Itemizer) ->
    appData = {}

    base = Configuration.baseUrl

    servicer =
      JOBS: 'jobs'

      MINIONS: 'minions'

      getJobs: () ->
        return @get(@JOBS)

      getMinions: () ->
        return @get(@MINIONS)

      getAll: () ->
        return appData

      update: (data) ->
        for own key, val of data
            appData[key] = val
        return appData

      clear: () ->
        appData = {}
        return appData

      get: (key) ->
        return appData[key]

      set: (key, val) ->
        appData[key] = val
        return val

      del: (key) ->
        if key of appData
          delete appData[key]
        return appData

      keys: () ->
        return (key for own key of appData)

      clearSaltData: () ->
        @set('commands', new Itemizer())
        @set(@JOBS, new Itemizer())
        @set(@MINIONS, new Itemizer())
        @set('events', new Itemizer())
        return

      initSaltData: () ->
        @set('commands', new Itemizer()) if not @get('commands')
        @set(@JOBS, new Itemizer()) if not @get(@JOBS)
        @set(@MINIONS, new Itemizer()) if not @get(@MINIONS)
        @set('commands', new Itemizer()) if not @get('commands')

    return servicer
  ]
