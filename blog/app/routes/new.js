import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return this.store.createRecord('post');
  },

  actions: {
    /*save() {
      var title = $('.title').val();
      var author = $('.author').val();
      var summary = $('.summary').val();
      $.ajax({
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        method: "POST",
        url: "http://localhost:4000/api/posts",
        data: `{"post":{"title":"${title}", "author":"${author}", "summary":"${summary}"}}`
      })
    },*/
    save() {
      var post = this.currentModel;
      var self = this;
      post.save().then(function(resp) {
        console.log(resp);
        self.transitionTo('posts');
      });
    }
  }
});
