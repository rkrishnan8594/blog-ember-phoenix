import ApplicationAdapter from './application';

export default ApplicationAdapter.extend({
  urlForCreateRecord(modelName, snapshot) {
    var postID = snapshot.belongsTo("post").id;
    return `/${this.namespace}/posts/${postID}/comments`;
  }
});
