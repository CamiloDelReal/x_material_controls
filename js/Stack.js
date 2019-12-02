function Stack()
{
    var stack  = [];

    this.push = function(item) {
        stack.push(item);
    }

    this.pop = function() {
        return stack.pop();
    }
}
