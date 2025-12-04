///|
enum AVLNode {
  Empty
  Node(Int, Int, AVLNode, AVLNode)
}

///|
fn print_top_element(node : AVLNode, print_func: (Int) -> Unit, default_func: () -> Unit) -> Unit {
  match node {
    Empty => default_func()
    Node(value, _, _, _) => print_func(value)
  }
}

///|
fn height(node : AVLNode) -> Int {
  match node {
    Empty => 0
    Node(_, h, _, _) => h
  }
}

///|
fn balance_factor(node : AVLNode) -> Int {
  match node {
    Empty => 0
    Node(_, _, left, right) => height(left) - height(right)
  }
}

///|
fn update_height(value : Int, left : AVLNode, right : AVLNode) -> AVLNode {
  let left_height = height(left)
  let right_height = height(right)
  let max_height = if left_height > right_height { left_height } else { right_height };
  let new_height = 1 + max_height
  Node(value, new_height, left, right)
}

///|
fn rotate_right(node : AVLNode) -> AVLNode {
  match node {
    Node(y, _, Node(x, _, a, b), c) => {
      let new_y = update_height(y, b, c)
      update_height(x, a, new_y)
    };
    _ => node;
  }
}

///|
fn rotate_left(node : AVLNode) -> AVLNode {
  match node {
    Node(x, _, a, Node(y, _, b, c)) => {
      let new_x = update_height(x, a, b);
      update_height(y, new_x, c);
    };
    _ => node;
  }
}

///|
fn balance(value : Int, left : AVLNode, right : AVLNode) -> AVLNode {
  let node = update_height(value, left, right);
  let bf = balance_factor(node);
  
  if bf > 1 {
    match left {
      Node(_) => {
        if balance_factor(left) >= 0 {
          rotate_right(node)
        } else {
          let new_left = rotate_left(left);
          rotate_right(update_height(value, new_left, right))
        }
      };
      _ => node;
    }
  } else if bf < -1 {
    match right {
      Node(_) => {
        if balance_factor(right) <= 0 {
          rotate_left(node)
        } else {
          let new_right = rotate_right(right);
          rotate_left(update_height(value, left, new_right))
        }
      };
      _ => node;
    }
  } else {
    node
  }
}

///|
enum CompareResult {
  Equal;
  Less;
  Greater;
}

///|
fn insert(tree : AVLNode, value : Int, compare: (Int, Int) -> CompareResult) -> AVLNode {
  match tree {
    Empty => Node(value, 1, Empty, Empty);
    Node(v, _, left, right) => {
      match compare(value, v) {
        Equal => tree;
        Less => {
          let new_left = insert(left, value, compare);
          balance(v, new_left, right)
        };
        Greater => {
          let new_right = insert(right, value, compare);
          balance(v, left, new_right)
        };
      }
    }
  }
}

///|
fn main {
  let mut tree = Empty;
  fn compare(a: Int, b: Int) -> CompareResult {
    if a < b { Less }
    else if a > b { Greater }
    else { Equal }
  }
  fn insert_(tree: AVLNode, value: Int) -> AVLNode {
    insert(tree, value, compare)
  }
  let input_cnt = 1000;
  fn inner_insert(cnt) -> AVLNode {
    if cnt > input_cnt {
      tree
    } else {
      tree = insert_(tree, cnt);
      inner_insert(cnt + 1)
    }
  }
  tree = inner_insert(1);
  fn default_func() -> Unit {
    println("No elements in the tree")
  }
  fn print_int(value: Int) -> Unit {
    println(value)
  }
  print_top_element(tree, print_int, default_func)
}

