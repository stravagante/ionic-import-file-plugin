var PLUGIN_NAME = 'IonicImportFilePlugin';

var IonicImportFile = {
    
    registerFileHandler: function (successCallback, errorCallback) {
        cordova.exec(
                     successCallback,
                     errorCallback,
                     PLUGIN_NAME,
                     'registerFileHandler',
                     [])
    }
    };

module.exports = IonicImportFile;
