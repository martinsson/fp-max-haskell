import Test.Hspec
import Lib

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "mon test" $ do
    it "fait un truc" $ sayHello `shouldBe` PutStrLn "Hello World"
