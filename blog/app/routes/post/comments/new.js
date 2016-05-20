import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    var parent = this.modelFor("post");
    parent = this.store.peekRecord("post", parent.id);
    return this.store.createRecord('comment', {
      post: parent
    });
  },

  actions: {
    save() {
      var self = this;
      var comment = this.currentModel;
      var parent = this.modelFor("post");
      comment.save().then(function(resp) {
        self.transitionTo('post', parent.id);
      });
    },
    cancel() {
      var self = this;
      var comment = this.currentModel;
      var parent = this.modelFor("post");
      comment.destroyRecord().then(function(resp) {
        self.transitionTo('post', parent.id);
      });
    }
  }
});
